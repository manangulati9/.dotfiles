#!/bin/bash

LOCK_TIMEOUT=300
let DPMS_TIMEOUT=$LOCK_TIMEOUT+60
let SUSPEND_TIMEOUT=$DPMS_TIMEOUT+240

IDLE=~/.config/sway/idle

swayidle -w \
	timeout $LOCK_TIMEOUT "$IDLE/lock.sh" \
	timeout $DPMS_TIMEOUT "$IDLE/outputs_off.sh" \
	resume "$IDLE/outputs_on.sh" \
	timeout $SUSPEND_TIMEOUT "$IDLE/suspend.sh"
