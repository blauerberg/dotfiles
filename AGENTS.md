# Agent Instructions

This is a personal dotfiles repository. Keep changes small, practical, and easy
to review.

## Scope

- This repository links and loads configuration, and may manage zsh plugins and
  shell integration checkouts that are stored under this repository.
- Do not add system package, Homebrew package, language runtime, or shell
  framework installation responsibilities here.

## Workflow

For shared repository workflow such as verification, commit conventions, branch
usage, and documentation boundaries, follow `DEVELOPMENT.md`.

## Testing

- Follow `DEVELOPMENT.md` for shared verification policy and commands.
- Prefer checking supported behavior over asserting that removed or unsupported
  behavior stays absent.
- Test dotfiles contracts, not full configuration catalogs: loader behavior,
  public environment controls, conditional branches, bootstrap effects, and a
  small representative sample are better than exhaustive alias or keybinding
  snapshots.
- Do not add per-file absence checks for removed historical artifacts unless
  their absence is an explicit current contract; prune tests when the contract
  they protected no longer exists.
- Add or update tests only when they protect real dotfiles behavior, shell
  startup behavior, bootstrap behavior, environment-specific branching, or
  regression-prone logic.

## Documentation

- Follow `DEVELOPMENT.md` for documentation ownership and SSOT boundaries.
- In agent-facing docs, prefer stable repository intent over volatile
  implementation detail.

## Security

- Do not commit API keys, tokens, passwords, private keys, or machine-specific
  secrets.
- Keep secrets and local-only settings in ignored local files such as
  `~/.zshrc.local`, `~/.zshrc.env`, or `~/.gitconfig_local`.
- Do not print secrets in command output, logs, docs, or examples.
- Do not add network installers, credential handling, or secret-dependent
  behavior unless explicitly requested.
