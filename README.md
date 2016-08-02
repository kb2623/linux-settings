# linux-settings
Nastavitve za linux programe.

# Programi
nvim gvim spacefm

# Dodatne nastavitve
## Nvim
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
