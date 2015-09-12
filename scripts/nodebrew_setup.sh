#!/bin/bash

set -e

install_path=$HOME/.nodebrew

if [ -e $install_path ]; then
  echo "$install_path is already exists."
else
  curl -L git.io/nodebrew | perl - setup
fi
