#!/bin/bash

# Check if an argument is provided, if not, use fzf to select a directory from $HOME/Projects
if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find "$HOME"/.dotfiles -type f | fzf --preview 'bat --style=numbers --color=always {}' --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8)
fi

# If no directory is selected, exit
if [[ -z $selected ]]; then
  exit 0
fi

# Extract the name of the selected directory and replace dots with underscores
selected_name=$(basename "$selected")

# Check if tmux is running
tmux_running=$(pgrep tmux)

# If neither TMUX environment variable nor tmux process is running, start a new tmux session with the selected directory
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s "$selected_name" "nvim $selected"
  exit 0
fi

cd $(dirname "$selected") || return
tmux new-window -a -n "$selected_name" "nvim $selected"
