#!/usr/bin/env bash

function run {
	if ! pgrep $1 ; then
		$@&
	fi
}

run nm-applet
run volumeicon
run cbaticon

if xrandr | grep -q 'HDMI-0 connected' ; then
	xrandr --output HDMI-0 --primary --mode 1920x1200 --pos 0x0 --rotate normal --output DP-4 --off --output DP-3 --off --output DP-2 --off --output DP-1 --off --output DP-0 --mode 1920x1080 --pos 1920x120 --rotate normal
fi

# vim: tabstop=3 noexpandtab shiftwidth=3 softtabstop=3
