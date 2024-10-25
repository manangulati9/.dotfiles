#!/bin/env sh

sleep 2
directory=$HOME/Pictures/Wallpapers/

if [ -d "$directory" ]; then
  random_background=$(find "$directory" | shuf -n 1)

  hyprctl unload all
  hyprctl hyprpaper preload "$random_background"
  hyprctl hyprpaper wallpaper ", $random_background"
fi
