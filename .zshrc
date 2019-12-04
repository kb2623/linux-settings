# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/zsh

export ZPLUG_HOME=~/.zplug

if [[ ! -d $ZPLUG_HOME ]]; then
	git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

zplug romkatv/powerlevel10k, as:theme, depth:1
zplug zsh-users/zsh-completions
zplug zpm-zsh/ls
zplug zpm-zsh/tmux
zplug zpm-zsh/colors
zplug zpm-zsh/ssh
zplug zpm-zsh/dot
zplug zpm-zsh/dircolors-material
zplug zpm-zsh/history-substring-search-wrapper

zplug load romkatv/powerlevel10k
zplug load zsh-users/zsh-completions
zplug load zpm-zsh/ls
zplug load zpm-zsh/colors
zplug load zpm-zsh/tmux
zplug load zpm-zsh/ssh
zplug load zpm-zsh/dot
zplug load zpm-zsh/dircolors-material
zplug load zpm-zsh/history-substring-search-wrapper

if [[ -f ~/.zshrcadd  ]]; then
	source ~/.zshrcadd
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	source ~/.p10k.ssh.zsh
else
	source ~/.p10k.zsh
fi
