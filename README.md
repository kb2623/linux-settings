# linux-settings
Nastavitve za linux programe.

# Programi
* `git`
* `zsh`
* `tmux`
* `powerline`
* `vim` and `neovim`
* `neofetch`
* `vifm`

## Install command
```
sudo apt install git zsh tmux powerline vim neovim neofetch vifm
```

# Git Navodila
## Git global setup
```
git config --global user.name "user"
git config --global user.email "user@mail.com"
```
## Git setup
```
git init
git remote add origin https://github.com/kb2623/linux-settings.git
git submodule update --init --recursive
git pull origin master
```
## Git ukaz za podmodule
### Inicializacija
`git submodule update --init --recursive`

### Posodabljanje
```
git submodule update --recursive --remote
git submodule foreach git pull origin master
```

# Dodatne nastavitve
## Nvim
```
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config} && ln -s ~/.vim $XDG_CONFIG_HOME/nvim && ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
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

# SSL
## Create key
`openssl genrsa -des3 -out [file.key] 2048`

## Decript key
`openssl rsa -in [file1.key] -out [file2.key]`

## Create certificat
`openssl req -x509 -new -nodes -key [file.key] -sha256 -days 1024  -out [file.pem]`
