#!/usr/bin/env zsh

if [[ ! -f ~/.zpm/zpm.zsh  ]]; then
	git clone --recursive https://github.com/zpm-zsh/zpm ~/.zpm
fi
source ~/.zpm/zpm.zsh

### Core plugins
zpm zpm-zsh/core-config
zpm zpm-zsh/check-deps

### 3party plugins
zpm zpm-zsh/ls
zpm zpm-zsh/tmux
zpm zpm-zsh/colors
zpm zpm-zsh/ssh
zpm zpm-zsh/dot
zpm zpm-zsh/dircolors-material
zpm zpm-zsh/history-substring-search-wrapper
zpm zsh-users/zsh-completions

zpm load-if-not ssh zpm-zsh/autoenv

zpm load-if-not ssh psprint/history-search-multi-word
zpm load-if-not ssh zdharma/fast-syntax-highlighting
zpm load-if-not ssh tarruda/zsh-autosuggestions

### Themes
zpm load romkatv/powerlevel10k

# colors
PYGMENTIZE_THEME=material

if [[ -f ~/.zshrcadd  ]]; then
	source ~/.zshrcadd
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	source ~/.p10k.ssh.zsh
else
	source ~/.p10k.zsh
fi 
