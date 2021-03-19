#!/bin/sh

# X11 profile
[ -f ~/.xprofile ] && . ~/.xprofile

# Shell variables
[ -f ~/.profile ] && . ~/.profile

# X11 resources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources &

awesome
