# linux-settings
Nastavitve za linux programe.

# Navodila
## Command line instructions
### Git global setup
```
git config --global user.name "user"
git config --global user.email "user@mail.com"
```
### Create a new repository
```
git clone https://kb2623@gitlab.com/kb2623/obVaja.git
cd obVaja
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```
### Existing folder
```
cd existing_folder
git init
git remote add origin https://kb2623@gitlab.com/kb2623/obVaja.git
git add .
git commit
git push -u origin master
```
### Existing Git repository
```
cd existing_repo
git remote add origin https://kb2623@gitlab.com/kb2623/obVaja.git
git push -u origin --all
git push -u origin --tags
```
## Navodila za nastavitev git repozitorija v delujocega direktorija
```
cd <localDir>
git init
git add -A .
git pull <url> master
git commit -m "message"
git remote add origin <url>
git push
```

## Git ukaz za podmodule
```
git submodule foreach git pull origin master
git submodule update --recursive --remote
git submodule update --init --recursive
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
