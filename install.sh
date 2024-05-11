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
	PACKAGEMANAGER='apt dnf pacman zypper'
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

enableCopr() {
	if [[ $PACKAGER == "dnf" ]]; then
		sudo dnf copr enable atim/lazygit -y
	fi
}

installDepend() {
	## Check for dependencies.
	DEPENDENCIES='flameshot tldr tmux flatpak kitty htop thunar vlc zathura zathura-pdf-mupdf libreoffice go neovim rofi-wayland autojump bash-completion tar grep curl fzf qt6-qtsvg qt6-qtdeclarative qt6-qtdeclarative-devel lazygit nodejs'
	echo -e "${YELLOW}Installing dependencies...${RC}"
	if [[ $PACKAGER == "pacman" ]]; then
		if ! command_exists yay; then
			echo "Installing yay..."
			sudo ${PACKAGER} --noconfirm -S base-devel
			$(cd /opt && sudo git clone https://aur.archlinux.org/yay.git && sudo chown -R ${USER}:${USER} ./yay && cd yay && makepkg --noconfirm -si)
		else
			echo "Command yay already installed"
		fi
		yay --noconfirm -S ${DEPENDENCIES}
	else
		sudo ${PACKAGER} install -y ${DEPENDENCIES}
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

	if [[ $PACKAGER == "pacman" ]]; then
		if ! command_exists yay; then
			echo "Installing yay..."
			sudo ${PACKAGER} --noconfirm -S base-devel
			$(cd /opt && sudo git clone https://aur.archlinux.org/yay-git.git && sudo chown -R ${USER}:${USER} ./yay-git && cd yay-git && makepkg --noconfirm -si)
		else
			echo "Command yay already installed"
		fi
		yay --noconfirm -S brave-bin
	elif [[$PACKAGER == "apt" || $PACKAGER == "apt-get"]]; then
		sudo apt install curl
		sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
		echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
		sudo apt update
		sudo apt install brave-browser
	else
		sudo dnf install dnf-plugins-core
		sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
		sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
		sudo dnf install brave-browser
	fi
}

installFlatpakApps() {
	if checkFlatpakApp dev.vencord.Vesktop && checkFlatpakApp com.spotify.Client; then
		echo "Flatpak apps already setup!"
		return
	fi

	if command_exists flatpak; then
		echo -e "${YELLOW}Installing flatpak apps...${RC}"
		flatpak override --filesystem=$HOME/.themes
		flatpak override --filesystem=$HOME/.icons
		flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
		flatpak install -y flathub dev.vencord.Vesktop
		flatpak install -y flathub com.spotify.Client
		bash <(curl -sSL https://spotx-official.github.io/run.sh)
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
enableCopr
installDepend
installStarship
installZoxide
installBrave
installTmuxTPM
installBun
if installFlatpakApps; then
	echo -e "${GREEN}Done!\nLogout and login to see changes.${RC}"
else
	echo -e "${RED}Something went wrong!${RC}"
fi
