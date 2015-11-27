#!/bin/bash
#
# Install Node.js
#   - `scripts/nodebrew_setup.sh` and `source .zshenv`
#   - `nodebrew ls-remote`
#   - `nodebrew install v4.2.2`
#   - `nodebrew use v4.2.2`
#

set -e

install_path=$HOME/.nodebrew

if [ -e $install_path ]; then
  echo "$install_path is already exists."
else
  curl -L git.io/nodebrew | perl - setup
fi
