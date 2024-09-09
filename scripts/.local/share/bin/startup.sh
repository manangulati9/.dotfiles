#!/usr/bin/env sh

# Setting gtk-theme
config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
if [ ! -f "$config" ]; then exit 1; fi

cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_size="$(grep 'gtk-cursor-theme-size' "$config" | sed 's/.*\s*=\s*//')"

# Overriding flatpak theme to follow gtk-theme
flatpak override --env=CURSOR_THEME="$cursor_theme"
flatpak override --env=CURSOR_SIZE="$cursor_size"

# Starting docker daemon
systemctl start docker

# Removing old linux kernels
# sudo sh "$HOME"/.local/bin/kernel-cleanup.sh
