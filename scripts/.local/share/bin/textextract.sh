#!/usr/bin/env sh

grim -g "$(slurp)" - | tesseract - - | wl-copy && notify-send "Copied to clipboard!"
