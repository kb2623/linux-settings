if [ -f ~/.zshrcadd ]; then
    source ~/.zshrcadd
fi

autoload -Uz compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt adam2

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export JAVA_FONTS=/usr/share/fonts/TTF
export JAVA_OPTIONS='-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox
export ANDROID_HOME=/home/klemen/programs/Android/
export SAL_USE_VCLPLUGIN=gtk3

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
alias keyboard-awesome='setxkbmap -layout \"us,si\"'
alias lockui='i3lock -c 000000'
alias vncserver0x='x0vncserver -PassWordFile=~/.vnc/passwd'

# ex - archive extractor
# usage: ex <file>
ex ()
{
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
