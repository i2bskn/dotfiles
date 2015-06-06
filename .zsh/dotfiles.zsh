typeset -U path

if [ -d $HOME/dotfiles/bin ]; then
  export PATH=$PATH:$HOME/dotfiles/bin
fi

if [ -d $HOME/bin ]; then
  export PATH=$PATH:$HOME/bin
fi
