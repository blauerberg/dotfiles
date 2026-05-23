# dotfiles

My dotfiles.

## Supported Environments

- macOS with Ghostty and cmux
- Linux hosts, with Ubuntu 24.04 or newer as the primary target
- Dev Containers based on `mcr.microsoft.com/devcontainers/base:noble`

## Responsibility

This repository links and loads configuration only. It does not install system
packages, Homebrew packages, language runtimes, or shell frameworks.

Install tools with the host package manager, `devcontainer.json`, or a
Dockerfile. Shell startup checks whether optional commands exist before loading
their integration.

## Optional Tools

- Oh My Zsh: used when it is already installed. zsh falls back to native
  completion and a simple prompt when it is not available.
- fzf: loaded when `fzf` exists and the shell has an interactive line editor.
- mise: loaded in shim mode by default. Set `DOTFILES_MISE_MODE=full` before
  zsh starts if you want full `mise activate zsh` hook behavior.
- awscli: completion is enabled when `aws_completer` exists.
- Google Cloud CLI: completion is enabled when `gcloud` and a known completion
  file exist.
- tmux: auto-attaches on non-macOS interactive zsh sessions when `tmux` exists.
  Set `DOTFILES_DISABLE_TMUX_AUTO=1` to disable this.

## Local Files

These files are created if missing and are intentionally not managed here:

- `~/.zshrc.local`: machine-specific shell settings and secrets.
- `~/.gitconfig_local`: machine-specific Git includes and identities.

## Getting Started

```
git clone https://github.com/blauerberg/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

## Verification

```
sh tests/bootstrap.sh
zsh -n zsh/zshrc
```

## License

MIT
