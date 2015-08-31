# Not output coredump
limit coredumpsize 0

# umask
umask 022

typeset -U path fpath

# rbenv
if [ -e $HOME/.rbenv  ]; then
  export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
  eval "$(rbenv init -)"
fi

# nodebrew
if [ -d $HOME/.nodebrew ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# golang
if [ -e $HOME/go ]; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

# zsh-completions
if [ -d /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# direnv
if which direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Utilities
[ -d $HOME/dotfiles/bin ] && export PATH=$PATH:$HOME/dotfiles/bin
[ -d $HOME/bin ] && export PATH=$PATH:$HOME/bin
