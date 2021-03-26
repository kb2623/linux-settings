#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

OS=`uname -s`
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
sysxprofile=/etc/.xprofile

[ -f $sysxprofile ] && . $sysxprofile
[ -f $sysresources  ] && xrdb -merge $sysresources
[ -f $sysmodmap  ] && xmodmap $sysmodmap

# X11 profile
[ -f ~/.xprofile ] && . ~/.xprofile

# Shell variables
[ -f ~/.profile ] && . ~/.profile

# X11 resources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources &

awesome
