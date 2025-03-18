#!/bin/env sh

if [ -z "$1" ]; then
  swww img ~/Pictures/Wallpapers/samurai_strike.jpg --transition-step 255 --transition-fps 255
  exit 1
fi

directory=$HOME/Pictures/Wallpapers/

if [ "$1" == "r" ]; then
  if [ -d "$directory" ]; then
    random_background=$(find "$directory" | shuf -n 1)

    swww img "$random_background" --transition-step 30 --transition-fps 60
  fi
fi
