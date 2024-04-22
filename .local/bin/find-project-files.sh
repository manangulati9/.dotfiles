#!/usr/bin/env bash

# Check if an argument is provided, if not, use fzf to select a directory from $HOME/Projects
if [[ $# -eq 1 ]]; then
	selected=$1
else
	selected=$(find $HOME/Projects -mindepth 1 -maxdepth 1 -type d | fzf)
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
	tmux new-session -s $selected_name -c $selected nvim
	# Check if package.json exists in the directory
	if [ -f "$selected/package.json" ]; then
		tmux new-window -ad -c $selected -n "shell" -t $selected_name &
		tmux new-window -ad -c $selected -n "server" -t $selected_name "bun dev;sleep 1000"
	fi
	exit 0
fi

# If a tmux session with the selected directory name doesn't exist, create a new detached session with the selected directory
if ! tmux has-session -t=$selected_name 2>/dev/null; then
	tmux new-session -ds $selected_name -c $selected nvim
	# Check if package.json exists in the directory
	if [ -f "$selected/package.json" ]; then
		tmux new-window -ad -c $selected -n "shell" -t $selected_name &
		tmux new-window -ad -c $selected -n "server" -t $selected_name "bun dev;sleep 1000"
	fi
fi

# Switch to the tmux session with the selected directory name
tmux switch-client -t $selected_name
