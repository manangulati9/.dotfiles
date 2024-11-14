#!/usr/bin/env sh

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

tmux new-window -n "$session" -c "$project"
sleep 0.15
tmux send-keys "nvim" ENTER \; split-window -dh -c "$project" -l 70
