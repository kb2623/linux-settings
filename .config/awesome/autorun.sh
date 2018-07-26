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
	sh .screenlayout/startup.sh
fi

# vim: tabstop=3 noexpandtab shiftwidth=3 softtabstop=3
