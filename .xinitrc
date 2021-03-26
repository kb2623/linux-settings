#!/bin/sh

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

OS=`uname -s`
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
sysxprofile=/etc/.xprofile

[ -f $sysxprofile ] && source $sysxprofile
[ -f $sysresources  ] && xrdb -merge $sysresources
[ -f $sysmodmap  ] && xmodmap $sysmodmap

# X11 profile
[ -f ~/.xprofile ] && source ~/.xprofile

# Shell variables
[ -f ~/.profile ] && source ~/.profile

# X11 resources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources &

awesome
