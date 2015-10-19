#!/bin/bash
#
# Install Node.js
#   - `scripts/nodebrew_setup.sh` and `source .zshenv`
#   - `pyenv global system`
#   - `nodebrew ls-remote`
#   - `nodebrew install v0.12.7`
#   - `nodebrew use v0.12.7`
#

set -e

install_path=$HOME/.nodebrew

if [ -e $install_path ]; then
  echo "$install_path is already exists."
else
  curl -L git.io/nodebrew | perl - setup
fi
