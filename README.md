# dotfiles

My dotfiles.

This repository links and loads configuration, and may install zsh plugins
managed by this repository. For architecture and repository conventions, see
[ARCHITECTURE.md](ARCHITECTURE.md).

## Supported Environments

- macOS with Ghostty and cmux
- Linux hosts
- Dev Containers

## Local Files

These files are created if missing and are intentionally not managed here:

- `~/.zshrc.local`: machine-specific shell settings and secrets.
- `~/.zshrc.env`: early shell environment settings loaded before Oh My Zsh.
- `~/.gitconfig_local`: machine-specific Git includes and identities.

## Getting Started

```
git clone https://github.com/blauerberg/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

## License

MIT
