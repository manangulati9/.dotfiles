#!/bin/sh

# Setting gtk-theme
config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
if [ ! -f "$config" ]; then exit 1; fi

gnome_schema="org.gnome.desktop.interface"
gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_size="$(grep 'gtk-cursor-theme-size' "$config" | sed 's/.*\s*=\s*//')"
font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"

# Setting wayland envs
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway

# Overriding flatpak theme to follow gtk-theme
flatpak override --env=GTK_THEME="$gtk_theme"
flatpak override --env=ICON_THEME="$icon_theme"
flatpak override --env=CURSOR_THEME="$cursor_theme"
flatpak override --env=CURSOR_SIZE="$cursor_size"
flatpak override --env=FONT_NAME="$font_name"

# Starting docker daemon
systemctl start docker
