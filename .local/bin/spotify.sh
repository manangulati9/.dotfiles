#!/bin/sh

text="$(playerctl -p spotify metadata title) - $(playerctl -p spotify metadata artist)"

echo "{\"text\": \" $text\"}"
