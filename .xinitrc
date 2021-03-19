#!/bin/sh

# X11 resources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# X11 profile
[[ -f ~/.xprofile ]] && source ~/.xprofile

# Shell variables
[[ -f ~/.profile ]] && source ~/.profile

awesome
