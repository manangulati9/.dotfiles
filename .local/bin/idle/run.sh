#!/bin/bash

LOCK_TIMEOUT=300
SUSPEND_TIMEOUT=600
IDLE=$HOME/.config/sway/idle

swayidle \
	timeout $LOCK_TIMEOUT "$IDLE/autolock.sh" \
	timeout $SUSPEND_TIMEOUT "$IDLE/suspend.sh"
