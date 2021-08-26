#!/bin/bash
#
# Install Python
#   - `scripts/pyenv_setup.sh` and `source .zshenv`
#   - `pyenv install -l`
#   - `pyenv install 3.7.3`
#   - `pyenv global 3.7.3`
#   - `pip install awscli`
#   - `pip install pipenv`
#

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
  git clone https://github.com/pyenv/pyenv.git $install_path
fi

# ---------------
# plugins
# ---------------
[ ! -e $plugin_dir ] && mkdir -pv $plugin_dir

if [ -d $plugin_dir ]; then
  # pyenv-update
  if [ -e $plugin_dir/pyenv-update ]; then
    echo "pyenv-update is already installed."
  else
    git clone git://github.com/yyuu/pyenv-update.git $plugin_dir/pyenv-update
  fi
fi

if ! which pyenv > /dev/null 2>&1; then
  echo -e "\033[31mMust be set following.\033[m"
  echo "----- start -----"
  echo 'export PYENV_ROOT="$HOME/.pyenv"'
  echo 'export PATH="$PYENV_ROOT/bin:$PATH"'
  echo 'eval "$(pyenv init --path)"'
  echo "----- end -----"
fi
