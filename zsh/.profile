# main
export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin:"
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export GDK_SCALE=1
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland

# fzf colors
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313245,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd7f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b5befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45476a \
--multi"

# variable exports
export EDITOR=nvim
export VISUAL=nvim

# color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[02;31m'
export LESS_TERMCAP_md=$'\E[02;31m'
export LESS_TERMCAP_me=$'\E[1m'
export LESS_TERMCAP_se=$'\E[1m'
export LESS_TERMCAP_so=$'\E[02;44;33m'
export LESS_TERMCAP_ue=$'\E[1m'
export LESS_TERMCAP_us=$'\E[02;32m'

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
export GOPATH=$HOME/go

# zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7c757d"
