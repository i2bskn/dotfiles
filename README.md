# dotfiles

i2bskn's macOS development environment managed by [chezmoi](https://www.chezmoi.io/).

## 🚀 Quick Start

```zsh
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply i2bskn
```

## 🛠 Features

- **Package Management**: [Homebrew](https://brew.sh/) (via `Brewfile`)
- **Runtime Manager**: [mise](https://mise.jdx.dev/) (Better & Faster than asdf/pyenv)
- **Shell**: Zsh + [starship](https://starship.rs/) + fzf
- **Editor**: Neovim
- **Dotfiles Tool**: [chezmoi](https://www.chezmoi.io/)

## 📝 Usage

### Add/Remove Packages

```zsh
v $(chezmoi source-path)/Brewfile
chezmoi apply
```

### Disable Brewfile Cleanup

By default, `chezmoi apply` runs `brew bundle --cleanup`, which removes packages not listed in `Brewfile`.

To disable this behavior on specific machines, create `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    brew_cleanup = false
```

### Manage Language Versions

```zsh
# ex：Node.js
mise use -g node@latest
mise ls
```

### Update settings

```zsh
# edit
v ~/.zshrc

# chezmoi
chezmoi re-add ~/.zshrc

# commit and push
cd $(chezmoi source-path)
git add .
git commit -m "Update settings"
git push
```

