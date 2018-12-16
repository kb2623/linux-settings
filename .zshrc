source /usr/share/zsh-antigen/antigen.zsh
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

# Load the theme.
# antigen theme robbyrussell
antigen theme agnoster
# antigen theme amuse

# Tell Antigen that you're done.
antigen apply


