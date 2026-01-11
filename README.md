# dotfiles

Configuration files for macOS, managed by [chezmoi](https://www.chezmoi.io/).

## Quick Start

Initialize and apply dotfiles on a new machine:

    chezmoi init --apply i2bskn

## Tools

- **Manager**: [chezmoi](https://www.chezmoi.io/)
- **Package Manager**: [Homebrew](https://brew.sh/)
- **Runtime Manager**: [mise](https://mise.jdx.dev/)
- **Shell**: zsh + [Starship](https://starship.rs/)
- **Terminal**: [WezTerm](https://wezfurlong.org/wezterm/)
- **Editor**: [Neovim](https://neovim.io/) ([LazyVim](https://www.lazyvim.org/))

## Usage

### Manage Dotfiles

Add a new file:

    chezmoi add ~/.file

Apply changes:

    chezmoi apply

### Manage Runtimes

Manage languages and tools with [mise](https://mise.jdx.dev/).

    mise install

