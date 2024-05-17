#!/bin/bash

audio_playing() {
	if pactl list | grep RUNNING; then
		return 0
	else
		return 1
	fi
}

if ! audio_playing; then
	ddcutil setvcp 10 30
fi
