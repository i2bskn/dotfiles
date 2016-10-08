#!/bin/bash

set -e

install_path=~/.pyenv
plugin_dir=$install_path/plugins

# ---------------
# pyenv
# ---------------
git --version
if [ -e $install_path ]; then
  echo "$install_path is already exists."
else
  git clone https://github.com/yyuu/pyenv.git $install_path
fi

# ---------------
# plugins
# ---------------
[ ! -e $plugin_dir  ] && mkdir -pv $plugin_dir

if [ -d $plugin_dir  ]; then
  # pyenv-update
  if [ -e $plugin_dir/pyenv-update ]; then
    echo "pyenv-update is already installed."
  else
    git clone git://github.com/yyuu/pyenv-update.git $plugin_dir/pyenv-update
  fi
fi
