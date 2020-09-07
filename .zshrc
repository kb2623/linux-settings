#!/bin/zsh

# Environemnt variables -----------------------------------------------
export SAL_USE_VCLPLUGIN=gtk3
export ZPLUG_HOME=~/.zplug
export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export ANDROID_HOME=/home/klemen/programs/Android/

# Enable Vim mode in ZSH
bindkey -v
zle -N edit-command-line

# ZPlug ----------------------------------------------------------------
## Install zplug in needed
if [[ ! -d $ZPLUG_HOME ]]; then
	git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

## Load zplug
source $ZPLUG_HOME/init.zsh

## zplug plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-syntax-highlighting
zplug zpm-zsh/ls
zplug zpm-zsh/tmux
zplug zpm-zsh/colors
zplug zpm-zsh/ssh
zplug zpm-zsh/dot
zplug zpm-zsh/material-colors
zplug romkatv/powerlevel10k, as:theme, depth:1

## Install zplug plugins
# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
	zplug install
fi

## Load zplug plugins
zplug load

# ALIAS ----------------------------------------------------------------
alias keyboard-awesome='setxkbmap -layout \"us,si\"'
alias lockui='i3lock -c 000000'
alias pacmanClean='pacman -Rs $(pacman -Qtdq)'
alias yaourtClean='yaourt -Rs $(yaourt -Qtdq)'
alias pacmanUpdateMirrors='sudo pacman-mirrors --geoip'
alias nvimqt='nvim-qt --no-ext-tabline &> /dev/null &'
alias rcp='rsync -ah --progress'
if [[ -n $SSH_CONNECTION ]]; then
	alias vim='vim -u $HOME/.vimrc.nopower'
	alias nvim='nvim -u $HOME/.config/nvim/sshinit.vim'
fi

# BIND ------------------------------------------------------------------
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)

# THEME -----------------------------------------------------------------
if [[ -n $SSH_CONNECTION ]]; then
	source ~/.themes/p10k.ssh.zsh
else
	source ~/.themes/p10k.zsh
fi

# FUNCTIONS -------------------------------------------------------------
# ex - archive extractor
# Usage: ex <file>
# Args:
#	$1 -> File
ex() {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1   ;;
			*.tar.gz)    tar xzf $1   ;;
			*.bz2)       bunzip2 $1   ;;
			*.rar)       unrar x $1   ;;
			*.gz)        gunzip $1    ;;
			*.tar)       tar xf $1    ;;
			*.tbz2)      tar xjf $1   ;;
			*.tgz)       tar xzf $1   ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1;;
			*.7z)        7z x $1      ;;
			*)           echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# vnc.ssh - VNC viewer over SSH tunnel
# Usage: vnc.ssh <ssh_addr> [<port>]
# Args:
#	$1 -> String representing hostname or user@hostname
#	$2 -> Port to farward
vnc.ssh () {
	port=5901
	if (( $# == 0 )); then
		return 1
	elif (( $# == 2 )); then
		port=$2
	fi
	ssh -L ${port}:localhost:5901 $1 -f sleep 10
	out=$(vncviewer localhost:1)
	return ${out}
}
