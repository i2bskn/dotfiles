My dotfiles
===========

dotfiles for OSX and Linux.

Requirements
------------

#### OSX

- Command Line Tools
    - Xcode install and execute `xcode-select --install`.
    - Execute `sudo xcodebuild -license` for agree to the license.
- [Homebrew](http://brew.sh/)

Installation
------------

Clone repository and create symlinks.

```
git clone --recursive git@github.com:i2bskn/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
make install
```

#### Misc

###### Packages install (OSX)

Install with homebrew.

```
brew update
brew tap Homebrew/bundle
brew bundle
brew linkapps macvim
```

Middleware config files in `conf.d/etcfiles`.

###### Fonts

1. Install by double-clicking the font files in `fonts`.

###### Change login shell to Zsh

1. Add `/usr/local/bin/zsh` to `/etc/shells`.
1. Execute `chpass -s /usr/local/bin/zsh`.

###### Apply settings to iTerm2

1. Setting `~/dotfiles/conf.d/iterm2` to `Load preferences from a custom folder or URL`.
1. Restart iTerm2.

###### Install version managers

Execute setup script in `scripts`.
