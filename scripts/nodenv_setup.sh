#!/bin/bash
#
# Install Ruby
#   - `scripts/rbenv_setup.sh` and `source .zshenv`
#   - `rbenv install -l`
#   - `RUBY_CONFIGURE_OPTS=--with-jemalloc rbenv install 2.2.3`
#   - `rbenv global 2.2.3`
#

set -e

install_path=~/.nodenv
plugin_dir=$install_path/plugins

# ---------------
# nodenv
# ---------------
git --version
if [ -e $install_path ]; then
  echo "$install_path is already exists."
else
  git clone https://github.com/nodenv/nodenv.git $install_path
fi

# ---------------
# plugins
# ---------------
[ ! -e $plugin_dir ] && mkdir -pv $plugin_dir

if [ -d $plugin_dir ]; then
  # node-build
  if [ -e $plugin_dir/node-build ]; then
    echo "node-build is already installed."
  else
    git clone https://github.com/nodenv/node-build.git $plugin_dir/node-build
  fi
fi

if ! which rbenv > /dev/null 2>&1; then
  echo -e "\033[31mMust be set following.\033[m"
  echo "----- start -----"
  echo 'export PATH="$HOME/.nodenv/bin:$PATH"'
  echo 'eval "$(nodenv init -)"'
  echo "----- end -----"
fi

