My dotfiles
===========

dotfiles for OSX and Linux.

Requirements
------------

- Command Line Tools
    - Xcode install and execute `xcode-select --install`.
    - Execute `sudo xcodebuild -license` for agree to the license.
- [Homebrew](http://brew.sh/)

Installation
------------

Clone repository and install homebrew packages and create symlinks.

```
curl -fsSL http://git.io/A7IM | bash
```

- Increase the priority of `/usr/local/bin` in `/etc/paths` for use latest packages.
- Change login shell to `zsh`.
    - Add `/usr/local/bin/zsh` to `/etc/shells`.
    - Execute `chpass -s /usr/local/bin/zsh`.
- Apply settings to iTerm2.
    - Setting `~/dotfiles/conf.d/iterm2` to `Load preferences from a custom folder or URL`.
    - Restart iTerm2.

