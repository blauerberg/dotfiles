# Architecture

This document is the canonical description of the repository's structure and
runtime behavior. `README.md` stays focused on the human-facing entry point and
setup flow, and `DEVELOPMENT.md` covers development workflow and verification.

## Responsibility

This repository links and loads configuration, and installs repo-managed zsh
plugins and shell integration checkouts. It does not install system packages,
Homebrew packages, language runtimes, or shell frameworks.

Install tools with the host package manager, `devcontainer.json`, or a
Dockerfile. Shell startup checks whether optional commands exist before loading
their integration.

## Shell Configuration

The zsh entry point is `zsh/zshrc`. Shared behavior is split under
`zsh/lib/*.zsh`, and optional command-specific integrations live under
`zsh/lib/integrations/*.zsh`.

User-facing controls:

- Oh My Zsh: used when it is already installed. zsh falls back to native
  completion and a simple prompt when it is not available. Override
  `DOTFILES_ZSH_THEME` in `~/.zshrc.env` to choose a theme without replacing
  the upstream `ZSH_THEME` variable directly.
- Oh My Zsh plugins: repo-managed plugins are installed by `bootstrap.sh`. Set
  `DOTFILES_OMZ_PLUGINS` to a space-separated plugin list to override the
  defaults.
- Prompt badge: the prompt is prefixed with a colored badge so the shell is easy
  to tell apart by environment.
  - Inside containers (detected via `REMOTE_CONTAINERS`, `CODESPACES`, or
    `DEVCONTAINER`) it shows a red `🐳 CONTAINER` badge; on a Linux host it shows
    a blue `🐧 LINUX` badge, and the container badge takes precedence.
  - Set `DOTFILES_CONTAINER_BADGE` or `DOTFILES_HOST_BADGE` to change the label,
    or either to an empty string to disable it.
- fzf Git bindings: `bootstrap.sh` installs `junegunn/fzf-git.sh` under
  `vendor/`, and zsh loads it when `fzf` is available.
- mise: loaded in shim mode by default. Set `DOTFILES_MISE_MODE=full` before
  zsh starts if you want full `mise activate zsh` hook behavior.
- tmux: auto-attaches on non-macOS interactive zsh sessions when `tmux` exists.
  Set `DOTFILES_DISABLE_TMUX_AUTO=1` to disable this.
- Tests and one-off checks: set `DOTFILES_SKIP_INTEGRATIONS=1` to skip optional
  command integrations while still loading the base zsh config.

## Neovim

Neovim configuration lives under `.config/nvim` and targets Neovim 0.12+.
Plain Vim uses `~/.vimrc` with no plugins; Neovim sources the same `.vimrc` and
layers Lua plugins on top via lazy.nvim, which installs itself on first launch.
Keymaps are discoverable in Neovim through which-key.nvim and the `<leader>?`
help group.

Neovim itself and language servers are not managed here. Install Neovim 0.12+
and any language servers with the host package manager, `devcontainer.json`, or
a Dockerfile. The Neovim config enables only language servers whose executables
are present on `PATH`.

## Local Files

These files are created if missing and are intentionally not managed here:

- `~/.zshrc.local`: machine-specific shell settings and secrets.
- `~/.zshrc.env`: early shell environment settings loaded before Oh My Zsh.
- `~/.gitconfig_local`: machine-specific Git includes and identities.
