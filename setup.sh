#!/bin/bash

set -eux

ln -sf $PWD/.agignore $HOME/.agignore
ln -sf $PWD/.ctags $HOME/.ctags
ln -sf $PWD/.gemrc $HOME/.gemrc
ln -sfn $PWD/.git_template $HOME/.git_template
ln -sf $PWD/.gitconfig $HOME/.gitconfig
ln -sf $PWD/.gitignore.global $HOME/.gitignore.global
ln -sfn $PWD/.peco $HOME/.peco
ln -sf $PWD/.pryrc $HOME/.pryrc
ln -sf $PWD/.railsrc $HOME/.railsrc
ln -sf $PWD/.tigrc $HOME/.tigrc
ln -sf $PWD/.tmux.conf $HOME/.tmux.conf
ln -sfn $PWD/.vim $HOME/.vim
ln -sf $PWD/.vimrc $HOME/.vimrc
ln -sf $PWD/.zshenv $HOME/.zshenv
ln -sf $PWD/.zshrc $HOME/.zshrc
