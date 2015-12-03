# Not output coredump
limit coredumpsize 0

typeset -U path fpath

# rbenv
if [ -e $HOME/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# nodebrew
if [ -d $HOME/.nodebrew ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# golang
if which go > /dev/null; then
  export GOPATH=$HOME/ghq/go:$HOME/ghq
  export PATH=$PATH:$HOME/ghq/go/bin
fi

# zsh-completions
if [ -d /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# direnv
if which direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

# Utilities
[ -d $HOME/bin ] && export PATH=$PATH:$HOME/bin
