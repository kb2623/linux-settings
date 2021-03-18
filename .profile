#!/bin/sh
#
# ~/.profile
#
#

# Setting for the new UTF-8 terminal support
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

[[ -f ~/.extend.profile ]] && . ~/.extend.profile
