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
- Prompt badge: the prompt is prefixed with a colored badge so the shell is easy
  to tell apart by environment. Inside containers (detected via
  `REMOTE_CONTAINERS`, `CODESPACES`, or `DEVCONTAINER`) it shows a red
  `🐳 CONTAINER` badge; on a Linux host it shows a blue `🐧 LINUX` badge. The
  container badge takes precedence. Set `DOTFILES_CONTAINER_BADGE` or
  `DOTFILES_HOST_BADGE` to change the label, or either to an empty string to
  disable it.
- fzf Git bindings: `bootstrap.sh` installs `junegunn/fzf-git.sh` under
  `vendor/`, and zsh loads it when `fzf` is available.
- mise: loaded in shim mode by default. Set `DOTFILES_MISE_MODE=full` before
  zsh starts if you want full `mise activate zsh` hook behavior.
- tmux: auto-attaches on non-macOS interactive zsh sessions when `tmux` exists.
  Set `DOTFILES_DISABLE_TMUX_AUTO=1` to disable this.
- Tests and one-off checks: set `DOTFILES_SKIP_INTEGRATIONS=1` to skip optional
  command integrations while still loading the base zsh config.

## Neovim

Neovim configuration lives under `.config/nvim` and targets **Neovim 0.11+**
(it uses the built-in LSP config API and the default LSP/quickfix keymaps).
Plain Vim uses `~/.vimrc` with no plugins; Neovim sources the same `.vimrc` and
layers Lua plugins on top via lazy.nvim, which installs itself on first launch.

Ubuntu 24.04's `apt` package is too old (0.9). In Dev Containers, install a
0.11+ build via one of:

- the official release tarball (`nvim-linux-x86_64.tar.gz`, or
  `nvim-linux-arm64.tar.gz` on arm64) extracted into `/opt` with its `bin/` on
  `PATH`;
- `ppa:neovim-ppa/unstable`;
- `mise use -g neovim@<version>`.

Language servers are not managed here. Install them on the host, in
`devcontainer.json`, or in a Dockerfile; Neovim enables only those found on
`PATH`:

- TypeScript/JavaScript: `npm i -g typescript typescript-language-server`
- Python: `npm i -g pyright` or `pipx install pyright`
- Go: `gopls` (ships with the Go toolchain)
- Rust: `rust-analyzer` (via rustup)
- Lua: `lua-language-server`

On a fresh, offline container, prime plugins once with
`nvim --headless "+Lazy! sync" +qa`.

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
