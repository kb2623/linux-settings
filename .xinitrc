#!/bin/sh

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
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

#eval $(dbus-launch --sh-syntax)
exec awesome
