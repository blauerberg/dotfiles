# Agent Instructions

This is a personal dotfiles repository. Keep changes small, practical, and easy
to review.

## Scope

- This repository links and loads configuration, and may manage zsh plugins that
  are stored under this repository's Oh My Zsh custom directory.
- Do not add system package, Homebrew package, language runtime, or shell
  framework installation responsibilities here.

## Workflow

- Use Conventional Commits for commit messages.
- Do not create pull requests by default.
- For small changes, commit directly on the default branch.
- For larger changes, create a short-lived branch, finish the work there, merge
  it back into the default branch locally, then push.

## Testing

- Keep verification lightweight and relevant.
- Do not add tests just to satisfy a process.
- Use the smallest command that exercises the changed behavior.
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
- For documentation-only changes, proofreading is enough.

## Security

- Do not commit API keys, tokens, passwords, private keys, or machine-specific
  secrets.
- Keep secrets and local-only settings in ignored local files such as
  `~/.zshrc.local`, `~/.zshrc.env`, or `~/.gitconfig_local`.
- Do not print secrets in command output, logs, docs, or examples.
- Do not add network installers, credential handling, or secret-dependent
  behavior unless explicitly requested.
