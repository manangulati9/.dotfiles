#!/usr/bin/env bash

# Check if an argument is provided, if not, use fzf to select a directory from $HOME/Projects
if [[ $# -eq 1 ]]; then
	selected=$1
else
	selected=$(find $HOME/.dotfiles -type f | fzf)
fi

# If no directory is selected, exit
if [[ -z $selected ]]; then
	exit 0
fi

# Extract the name of the selected directory and replace dots with underscores
selected_name=$(basename "$selected" | tr . _)

# Check if tmux is running
tmux_running=$(pgrep tmux)

# If neither TMUX environment variable nor tmux process is running, start a new tmux session with the selected directory
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
	tmux new-session -s $selected_name "nvim $selected"
	exit 0
fi

tmux new-window -a -n $selected_name "nvim $selected"
