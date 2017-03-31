# linux-settings
Nastavitve za linux programe.

# Navodila za nastavitev git repozitorija v delujocega direktorija
```
cd <localDir>
git init
git add -A .
git pull <url> master
git commit -m "message"
git remote add origin <url>
git push
```

# Programi
```
nvim 
gvim 
spacefm
```

# Dodatne nastavitve
## Nvim
```
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
```
