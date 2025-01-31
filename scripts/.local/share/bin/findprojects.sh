#!/bin/bash

# Check if an argument is provided, if not, use fzf to select a directory from $HOME/Projects
if [[ $# -eq 1 ]]; then
  project=$1
else
  project=$(find "$HOME"/Projects -mindepth 1 -maxdepth 1 -type d | fzf --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8)
fi

# If no directory is selected, exit
if [[ -z $project ]]; then
  exit 0
fi

# Extract the name of the selected directory and replace dots with underscores
session=$(basename "$project" | tr . _)

# Check if tmux is running
tmux_running=$(pgrep tmux)

# If neither TMUX environment variable nor tmux process is running, start a new tmux session with the selected directory
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s "$session" -c "$project"
  sleep 0.2
  tmux send-keys -t "$session" "nvim" ENTER
  tmux new-window -ad -c "$project" -n "terminal" -t "$session"
  exit 0
fi

# If a tmux session with the selected directory name doesn't exist, create a new detached session with the selected directory
if ! tmux has-session -t="$session" 2>/dev/null; then
  tmux new-session -ds "$session" -c "$project"
  sleep 0.2
  tmux send-keys -t "$session" "nvim" ENTER
  tmux new-window -ad -c "$project" -n "terminal" -t "$session"
fi

# Switch to the tmux session with the selected directory name
tmux switch-client -t "$session"
