# dotfiles

My dotfiles.

## Supported Environments

- macOS with Ghostty and cmux
- Linux hosts
- Dev Containers

## Responsibility

This repository links and loads configuration, and installs zsh plugins managed
by this repository. It does not install system packages, Homebrew packages,
language runtimes, or shell frameworks.

Install tools with the host package manager, `devcontainer.json`, or a
Dockerfile. Shell startup checks whether optional commands exist before loading
their integration.

## Optional Tools

Shell integrations live under `zsh/lib/integrations/*.zsh` and load only when
their commands exist. User-facing controls:

- Oh My Zsh: used when it is already installed. zsh falls back to native
  completion and a simple prompt when it is not available. Override
  `DOTFILES_ZSH_THEME` in `~/.zshrc.env` to choose a theme without replacing
  the upstream `ZSH_THEME` variable directly.
- Oh My Zsh plugins: repo-managed plugins are installed by `bootstrap.sh`. Set
  `DOTFILES_OMZ_PLUGINS` to a space-separated plugin list to override the
  defaults.
- fzf Git bindings: `bootstrap.sh` installs `junegunn/fzf-git.sh` under
  `vendor/`, and zsh loads it when `fzf` is available.
- mise: loaded in shim mode by default. Set `DOTFILES_MISE_MODE=full` before
  zsh starts if you want full `mise activate zsh` hook behavior.
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
for test in tests/*.sh; do sh "$test"; done
zsh -n zsh/zshrc
```

## License

MIT
