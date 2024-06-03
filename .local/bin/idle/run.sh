#!/bin/bash

LOCK_TIMEOUT=480
let SCREEN_OFF_TIMEOUT=$LOCK_TIMEOUT+120

SCRIPT_PATH=~/.local/bin/idle

swayidle -w \
	timeout $LOCK_TIMEOUT "$SCRIPT_PATH/autolock.sh" \
	timeout $SCREEN_OFF_TIMEOUT "$SCRIPT_PATH/screen_off.sh" resume "sleep 1; swaymsg 'output * dpms on'" \
	before-sleep "$SCRIPT_PATH/autolock.sh"
