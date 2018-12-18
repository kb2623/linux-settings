source /usr/share/zsh/share/antigen.zsh
source ~/.zshrcadd

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

# Load the theme.
# antigen theme robbyrussell
antigen theme bhilburn/powerlevel9k powerlevel9k
# antigen theme amuse

# Tell Antigen that you're done.
antigen apply


