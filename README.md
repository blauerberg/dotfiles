# dotfiles

My dotfiles.

## Supported Environments

- macOS with Ghostty and cmux
- Linux hosts, with Ubuntu 24.04 or newer as the primary target
- Dev Containers based on `mcr.microsoft.com/devcontainers/base:noble`

## Responsibility

This repository links and loads configuration, and installs zsh plugins managed
by this repository. It does not install system packages, Homebrew packages,
language runtimes, or shell frameworks.

Install tools with the host package manager, `devcontainer.json`, or a
Dockerfile. Shell startup checks whether optional commands exist before loading
their integration.

## Optional Tools

- Oh My Zsh: used when it is already installed. zsh falls back to native
  completion and a simple prompt when it is not available. A default
  `DOTFILES_ZSH_THEME` is chosen per environment (macOS, Linux,
  devcontainer); override it in `~/.zshrc.env` to pick another theme
  without replacing the upstream `ZSH_THEME` variable directly.
- Oh My Zsh plugins: managed by `bootstrap.sh`. Set `DOTFILES_OMZ_PLUGINS` to
  a space-separated plugin list to override the defaults.
- fzf: loaded when `fzf` exists and the shell has an interactive line editor.
- mise: loaded in shim mode by default. Set `DOTFILES_MISE_MODE=full` before
  zsh starts if you want full `mise activate zsh` hook behavior.
- awscli: completion is enabled when `aws_completer` exists.
- Google Cloud CLI: completion is enabled when `gcloud` and a known completion
  file exist.
- tmux: auto-attaches on non-macOS interactive zsh sessions when `tmux` exists.
  Set `DOTFILES_DISABLE_TMUX_AUTO=1` to disable this.
- Tests and one-off checks: set `DOTFILES_SKIP_INTEGRATIONS=1` to skip optional
  command integrations while still loading the base zsh config.

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

## Verification

```
sh tests/bootstrap.sh
sh tests/zsh-early-env.sh
sh tests/zsh-integrations.sh
sh tests/zsh-lib-boundaries.sh
sh tests/zsh-oh-my-zsh.sh
sh tests/zsh-theme-defaults.sh
zsh -n zsh/zshrc
```

## License

MIT
