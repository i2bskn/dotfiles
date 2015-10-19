#!/bin/bash
#
# Install Python
#   - `scripts/pyenv_setup.sh` and `source .zshenv`
#   - `pyenv install -l`
#   - `pyenv install 3.4.3`
#   - `pyenv global 3.4.3`
#

set -e

install_path=~/.pyenv

# ---------------
# pyenv
# ---------------
git --version
if [ -e $install_path ]; then
  echo "$install_path is already exists."
else
  git clone https://github.com/yyuu/pyenv.git $install_path
fi

if ! which pyenv > /dev/null 2>&1; then
  echo -e "\033[31mMust be set following.\033[m"
  echo "----- start -----"
  echo 'export PYENV_ROOT="$HOME/.pyenv"'
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"'
  echo 'eval "$(pyenv init -)"'
  echo "----- end -----"
fi
