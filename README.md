# dotfiles

My dotfiles.

This repository links and loads configuration, and may install zsh plugins and
shell integration checkouts managed by this repository. For architecture, see
[ARCHITECTURE.md](ARCHITECTURE.md). For development workflow and documentation
responsibilities, see [DEVELOPMENT.md](DEVELOPMENT.md).

## Supported Environments

- macOS with Ghostty
- Linux hosts
- Dev Containers

## Local Files

These files are created if missing and are intentionally not managed here:

- `~/.zshrc.local`: machine-specific shell settings and secrets.
- `~/.zshrc.env`: early shell environment settings loaded before Oh My Zsh.
- `~/.gitconfig_local`: machine-specific Git includes and identities.

## Getting Started

Running `bootstrap.sh` links repo-managed config into `$HOME` and creates
ignored local files; review it first if those paths already have local config.

```
git clone https://github.com/blauerberg/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

## License

MIT
