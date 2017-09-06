# linux-settings
Nastavitve za linux programe.

# Programi
zsh xterm universal-ctags-git grml-zsh-config powerline-fonts-git archdroid-icon-theme

# Navodila
```
git init
git remote add origin https://github.com/kb2623/linux-settings/blob/master/README.md
git submodule update --init --recursive
git pull origin master
```
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

## Firefox
userChrome.css
```
@namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"); /* only needed once */

#TabsToolbar { height:25px!important; margin-top:-1px!important; margin-bottom:1px!important; }
#tabbrowser-tabs { height:25px!important; min-height:25px!important; }

.tab-background-start[selected=true]::after,
.tab-background-start[selected=true]::before,
.tab-background-start,
.tab-background-end,
.tab-background-end[selected=true]::after,
.tab-background-end[selected=true]::before {
  min-height:25px!important;
}

#VimFxMarkersContainer .marker {
  font-size: 15px !important; /* Specific font size. */
  text-transform: uppercase !important; 
}
```

# tmux cheatsheet

As configured in [my dotfiles](https://github.com/henrik/dotfiles/blob/master/tmux.conf).

start new:

    tmux

start new with session name:

    tmux new -s myname

attach:

    tmux a  #  (or at, or attach)

attach to named:

    tmux a -t myname

list sessions:

    tmux ls

kill session:

    tmux kill-session -t myname

In tmux, hit the prefix `ctrl+b` and then:

## Sessions

    :new<CR>  new session
    s  list sessions
    $  name session

## Windows (tabs)

    c           new window
    ,           name window
    w           list windows
    f           find window
    &           kill window
    .           move window - prompted for a new number
    :movew<CR>  move window to the next unused number

## Panes (splits)

    |  horizontal split
    -  vertical split
    
    o  swap panes
    q  show pane numbers
    x  kill pane
    ⍽  space - toggle between layouts

## Window/pane surgery

    :joinp -s :2<CR>  move window 2 into a new pane in the current window
    :joinp -t :1<CR>  move the current pane into a new pane in window 1

* [Move window to pane](http://unix.stackexchange.com/questions/14300/tmux-move-window-to-pane)
* [How to reorder windows](http://superuser.com/questions/343572/tmux-how-do-i-reorder-my-windows)

## Misc

    d  detach
    t  big clock
    ?  list shortcuts
    :  prompt

Resources:

* [cheat sheet](http://cheat.errtheblog.com/s/tmux/)

Notes:

* You can cmd+click URLs to open in iTerm.

TODO:

* Conf copy mode to use system clipboard. See PragProg book.
