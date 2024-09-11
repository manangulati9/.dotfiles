#!/usr/bin/env sh

# set variables

scrDir=$(dirname "$(realpath "$0")")
source $scrDir/globalcontrol.sh
dstDir="${confDir}/dunst"

export hypr_border
killall dunst
dunst &
