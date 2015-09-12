#!/bin/bash
#
# Setting in after this script is execute.
#
# Install Ruby
#   - `scripts/rbenv_setup.sh` and `source .zshenv`
#   - `rbenv install -l`
#   - `RUBY_CONFIGURE_OPTS=--with-jemalloc rbenv install 2.2.2`
#   - `rbenv global 2.2.2`
#
# envfile for rails projects (Only rails projects)
#   - `direnv edit` => Add `export PATH=$PWD/bin:$PATH`
#
# Install Python
#   - `scripts/pyenv_setup.sh` and `source .zshenv`
#   - `pyenv install -l`
#   - `pyenv install 3.4.3`
#   - `pyenv global 3.4.3`
#
# Install Node.js
#   - `scripts/nodebrew_setup.sh` and `source .zshenv`
#   - `pyenv global system`
#   - `nodebrew ls-remote`
#   - `nodebrew install v0.12.7`
#   - `nodebrew use v0.12.7`
#

set -e

LANG=C
DOTFILES_DIR=$HOME/dotfiles

function attention() {
  echo -e "\e[0;31m$1\e[0m"
}

# Require commands
for cmd in ruby git; do
  if ! which $cmd > /dev/null 2>&1; then
    attention "$cmd can not find."
    exit 1
  fi
done

# Install check
if [ -e $DOTFILES_DIR ]; then
  attention "dotfiles already installed."
  exit 1
fi

# Clone
if [ -e $HOME/.ssh/id_rsa ]; then
  repo=git@github.com:i2bskn/dotfiles.git
else
  repo=https://github.com/i2bskn/dotfiles.git
fi

git clone --recursive $repo $DOTFILES_DIR

if [ ENV["ONLY_CLONE"] == "" ]; then
  cd $DOTFILES_DIR

  if [[ $OSTYPE =~ "darwin*" ]]; then
    # Install homebrew packages
    brew update
    brew tap Homebrew/bundle
    brew bundle

    # Install fonts
    rake fonts_install
  fi

  # Setup dotfiles
  rake setup
fi
