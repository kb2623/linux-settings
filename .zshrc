#!/bin/zsh

# Environemnt variables -----------------------------------------------
export SAL_USE_VCLPLUGIN=gtk3
export ZPLUG_HOME=~/.zplug

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
zplug zpm-zsh/dircolors-material
zplug zpm-zsh/history-substring-search-wrapper
zplug romkatv/powerlevel10k, as:theme, depth:1

## Install zplug plugins
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

## Load zplug plugins
zplug load --verbose

# ALIAS ----------------------------------------------------------------
alias keyboard-awesome='setxkbmap -layout \"us,si\"'
alias lockui='i3lock -c 000000'
alias pacmanClean='pacman -Rs $(pacman -Qtdq)'
alias yaourtClean='yaourt -Rs $(yaourt -Qtdq)'
alias nvimqt='nvim-qt --no-ext-tabline &> /dev/null &'
if [ -n "$SSH_CONNECTION" ]; then
	alias vim='vim -u $HOME/.vimrc.nopower'
	alias nvim='nvim -u $HOME/.config/nvim/sshinit.vim'
fi

# ALIAS ----------------------------------------------------------------
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)

# Theme ---------------------------------------------------------------
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	source ~/.p10k.ssh.zsh
else
	source ~/.p10k.zsh
fi
