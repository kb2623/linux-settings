#!/usr/bin/env bash

run() {
	if (command -v $1 && ! pgrep $1); then
		$@&
	fi
}

# Background programs
run nm-applet
run volumeicon
run cbatticon
run blueman-applet

# Keyboard layouts
setxkbmap -layout "us,si"

# Multihead setup
if xrandr | grep -q 'HDMI-0 connected'; then
	sh .screenlayout/startup.sh
elif xrandr | grep -q 'DP-0 connected'; then
	sh .screenlayout/startup.sh
fi

# vim: tabstop=3 noexpandtab shiftwidth=3 softtabstop=3
