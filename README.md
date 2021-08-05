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
- goimports
    - Execute `go install golang.org/x/tools/cmd/goimports@latest`

Installation
------------

Clone repository and create symlinks.

```
git clone git@github.com:i2bskn/dotfiles.git $HOME/dotfiles
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
```

Middleware config files in `conf.d`.

###### Change login shell to Zsh

1. Add `/usr/local/bin/zsh` to `/etc/shells`.
1. Execute `chpass -s /usr/local/bin/zsh`.
