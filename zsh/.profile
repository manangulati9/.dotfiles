export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin:"

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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
export GOPATH=$HOME/go

# zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7c757d"
