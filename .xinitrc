#!/bin/sh

# X11 resources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &

# X11 profile
[[ -f ~/.xprofile ]] && source ~/.xprofile

# Shell variables
[[ -f ~/.profile ]] && source ~/.profile

awesome
