#!/bin/bash

set -e

install_path=~/.nvm

git --version

if [ -e $install_path ]; then
  echo "$install_path is already exists."
else
  git clone https://github.com/creationix/nvm.git $install_path
fi

if ! which nvm > /dev/null 2>&1; then
  echo -e "\033[31mMust be set following.\033[m"
  echo "----- start -----"
  echo "source $install_path/nvm.sh"
  echo "----- end -----"
fi

