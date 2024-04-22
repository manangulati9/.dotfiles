#!/bin/bash

RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

##### HELPER FUNCTIONS #####
command_exists() {
	command -v $1 >/dev/null 2>&1
}

checkFlatpakApp() {
	local app_name="$1"
	if flatpak list | grep "$app_name"; then
		return 0 # App is installed, return true (0)
	else
		return 1 # App is not installed, return false (1)
	fi
}

##### INSTALLER FUNCTIONS #####
checkEnv() {
	## Check for requirements.
	REQUIREMENTS='curl groups sudo'
	if ! command_exists ${REQUIREMENTS}; then
		echo -e "${RED}To run me, you need: ${REQUIREMENTS}${RC}"
		exit 1
	fi

	## Check Package Handeler
	PACKAGEMANAGER='apt yum dnf pacman zypper'
	for pgm in ${PACKAGEMANAGER}; do
		if command_exists ${pgm}; then
			PACKAGER=${pgm}
			echo -e "Using ${pgm}"
		fi
	done

	if [ -z "${PACKAGER}" ]; then
		echo -e "${RED}Can't find a supported package manager"
		exit 1
	fi

	## Check if the current directory is writable.
	GITPATH="$(dirname "$(realpath "$0")")"
	if [[ ! -w ${GITPATH} ]]; then
		echo -e "${RED}Can't write to ${GITPATH}${RC}"
		exit 1
	fi

	## Check SuperUser Group
	SUPERUSERGROUP='wheel sudo root'
	for sug in ${SUPERUSERGROUP}; do
		if groups | grep ${sug}; then
			SUGROUP=${sug}
			echo -e "Super user group ${SUGROUP}"
		fi
	done

	## Check if member of the sudo group.
	if ! groups | grep ${SUGROUP} >/dev/null; then
		echo -e "${RED}You need to be a member of the sudo group to run me!"
		exit 1
	fi

}

installDepend() {
	## Check for dependencies.
	DEPENDENCIES='git sway meld jpico swaylock-effects stow tmux firefox flatpak brave kitty htop thunar vlc zathura zathura-pdf-mupdf libreoffice lxappearance neovim rofi-wayland autojump bash bash-completion tar neovim grep curl'
	echo -e "${YELLOW}Installing dependencies...${RC}"
	if [[ $PACKAGER == "pacman" ]]; then
		if ! command_exists yay; then
			echo "Installing yay..."
			sudo ${PACKAGER} --noconfirm -S base-devel
			$(cd /opt && sudo git clone https://aur.archlinux.org/yay-git.git && sudo chown -R ${USER}:${USER} ./yay-git && cd yay-git && makepkg --noconfirm -si)
		else
			echo "Command yay already installed"
		fi
		yay --noconfirm -S ${DEPENDENCIES}
	else
		sudo ${PACKAGER} install -yq ${DEPENDENCIES}
	fi
}

installStarship() {
	if command_exists starship; then
		echo "Starship already installed"
		return
	fi

	if ! curl -sS https://starship.rs/install.sh | sh; then
		echo -e "${RED}Something went wrong during starship install!${RC}"
		exit 1
	fi
	if command_exists fzf; then
		echo "Fzf already installed"
	else
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install
	fi
}

installZoxide() {
	if command_exists zoxide; then
		echo "Zoxide already installed"
		return
	fi

	if ! curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh; then
		echo -e "${RED}Something went wrong during zoxide install!${RC}"
		exit 1
	fi
}

installBrave() {
	if command_exists brave-browser; then
		echo "Brave already installed"
		return
	fi

	sudo dnf install dnf-plugins-core
	sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	sudo dnf install brave-browser
}

installDotfiles() {
	if test -d "~/.dotfiles"; then
		echo "Dotfiles already setup!"
		return
	fi

	if command_exists stow; then
		echo -e "${YELLOW}Setting up dotfiles...${RC}"
		git clone https://github.com/manangulati9/.dotfiles.git ~/.dotfiles
		cd ~/.dotfiles
		stow .
	else
		echo -e "${RED}Something went wrong during stow install!${RC}"
		exit 1
	fi
}

installFlatpakApps() {
	if checkFlatpakApp dev.vencord.Vesktop && checkFlatpakApp com.spotify.Client; then
		echo "Flatpak apps already setup!"
		return
	fi

	if command_exists flatpak; then
		echo -e "${YELLOW}Installing flatpak apps...${RC}"
		flatpak install flathub dev.vencord.Vesktop
		flatpak install flathub com.spotify.Client
		bash <(curl -sSL https://raw.githubusercontent.com/SpotX-CLI/SpotX-Linux/main/install.sh) -P /var/lib/flatpak/app/com.spotify.Client/x86_64/stable/active/files/extra/share/spotify/
	else
		echo -e "${RED}Something went wrong during flatpak install!${RC}"
		exit 1
	fi
}

installTmuxTPM() {
	if test -d "~/.tmux/plugins/tpm"; then
		echo "tmux tpm already setup!"
		return
	fi

	echo -e "${YELLOW}Installing tmux tpm...${RC}"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	~/.tmux/plugins/tpm/scripts/install_plugins.sh
}

installBun() {
	if command_exists bun; then
		echo "Bun already installed!"
		return
	fi

	echo -e "${YELLOW}Installing bun...${RC}"
	curl -fsSL https://bun.sh/install | bash
}

##### EXECUTING COMMANDS #####
checkEnv
installDepend
installStarship
installZoxide
installBrave
installDotfiles
installTmuxTPM
installBun
if installFlatpakApps; then
	echo -e "${GREEN}Done!\nLogout and login to see changes.${RC}"
else
	echo -e "${RED}Something went wrong!${RC}"
fi
