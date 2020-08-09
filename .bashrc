if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
fi

xhost +local:root > /dev/null 2>&1

complete -cf sudo

set -o vi

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete

# Environemnt variables -----------------------------------------------
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export JAVA_FONTS=/usr/share/fonts/TTF
export _JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export ANDROID_HOME=/home/klemen/programs/Android/

# ALIAS ----------------------------------------------------------------
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias fixit='sudo rm -f /var/lib/pacman/db.lck'
alias update='yaourt -Syua'
alias con='nano $HOME/.i3/config'
alias comp='nano $HOME/.config/compton.conf'
alias inst='sudo pacman -S'
alias mirrors='sudo pacman-mirrors -g'
alias printer='system-config-printer'
alias lockui='i3lock -c 000000'
alias pacmanCleanPkg='pacman -Qqdt | sudo pacman -Rns -'
alias yaourtCleanPkg='yaourt -Qqdt | yaourt -Rns -'
alias rcp='rsync -ah --progress'

# Functions ------------------------------------------------------------
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
			*.rar)       unrar x $1     ;;
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

# prompt ----------------------------------------------------------------
if [ "$TERM" != "linux" ]; then
	source ~/.config/pureline/pureline ~/.config/pureline/configs/powerline_full_256col.conf
else
	PS1='┌[\[\e[32m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]]-[\[\e[33m\]\w\[\e[m\]]\\$\n└> '
fi
