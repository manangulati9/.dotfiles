#!/bin/bash

DIM_TIMEOUT=300
let LOCK_TIMEOUT=$DIM_TIMEOUT+60
let SCREEN_OFF_TIMEOUT=$LOCK_TIMEOUT+120
let SUSPEND_TIMEOUT=$SCREEN_OFF_TIMEOUT+120

SCRIPT_PATH=~/.local/bin/idle

swayidle -w \
	timeout $DIM_TIMEOUT "$SCRIPT_PATH/dim.sh" resume "ddcutil setvcp 10 100" \
	timeout $LOCK_TIMEOUT "$SCRIPT_PATH/autolock.sh" \
	timeout $SCREEN_OFF_TIMEOUT "$SCRIPT_PATH/screen_off.sh" resume "swaymsg 'output * dpms on'" \
	timeout $SUSPEND_TIMEOUT "$SCRIPT_PATH/suspend.sh" \
	before-sleep "$SCRIPT_PATH/autolock.sh"
