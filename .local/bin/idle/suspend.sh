#!/bin/bash

audio_playing() {
	if pactl list | grep RUNNING; then
		return 0
	else
		return 1
	fi
}

if ! audio_playing; then
	systemctl suspend -i
fi
