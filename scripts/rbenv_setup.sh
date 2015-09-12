#!/bin/bash

set -e

install_path=~/.rbenv
plugin_dir=$install_path/plugins

# ---------------
# rbenv
# ---------------
git --version
if [ -e $install_path ]; then
  echo "$install_path is already exists."
else
  git clone https://github.com/sstephenson/rbenv.git $install_path
fi

# ---------------
# plugins
# ---------------
[ ! -e $plugin_dir ] && mkdir -pv $plugin_dir

if [ -d $plugin_dir ]; then
  # ruby-build
  if [ -e $plugin_dir/ruby-build ]; then
    echo "ruby-build is already installed."
  else
    git clone https://github.com/sstephenson/ruby-build.git $plugin_dir/ruby-build
  fi

  # default-gems
  if [ -e $plugin_dir/rbenv-default-gems ]; then
    echo "rbenv-default-gems is already installed."
  else
    git clone https://github.com/sstephenson/rbenv-default-gems.git $plugin_dir/rbenv-default-gems
  fi

  default_gems_file=`dirname $0`/../conf.d/default-gems

  if [ -f $default_gems_file ]; then
    cp -fv $default_gems_file $install_path/default-gems
  else
    touch $install_path/default-gems
  fi

  # update
  if [ -e $plugin_dir/rbenv-update ]; then
    echo "rbenv-update is already installed."
  else
    git clone https://github.com/rkh/rbenv-update.git $plugin_dir/rbenv-update
  fi
fi

if ! which rbenv > /dev/null 2>&1; then
  echo -e "\033[31mMust be set following.\033[m"
  echo "----- start -----"
  echo 'export PATH=$HOME/.rbenv/bin:$PATH'
  echo 'eval "$(rbenv init -)"'
  echo "----- end -----"
fi
