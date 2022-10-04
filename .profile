#!/bin/sh

# Setting for the new UTF-8 terminal support
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LANG=en_US.UTF-8
export SAL_USE_VCLPLUGIN=kf5
export SAL_VCL_QT5_USE_CAIRO=1

[ -f ~/.extend.profile ] && . ~/.extend.profile
