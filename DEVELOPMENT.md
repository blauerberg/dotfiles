# Development

This document is the canonical description of how to make and verify changes in
this repository. `README.md` is the human-facing entry point,
`ARCHITECTURE.md` covers repository structure and runtime behavior, and
`AGENTS.md` adds agent-specific operating rules.

## Change Scope

Keep changes small, practical, and easy to review. Prefer the existing
structure, naming, and patterns in the repository over new abstractions or
incidental cleanup.

## Verification

Keep verification lightweight and relevant. Use the smallest command that
exercises the changed behavior.

- For documentation-only changes, proofreading and `git diff --check` are
  enough.
- For repository-wide shell checks, run:

```sh
for test in tests/*.sh; do sh "$test"; done
zsh -n zsh/zshrc
```

Prefer testing dotfiles contracts such as loader behavior, public environment
controls, conditional branches, bootstrap effects, and a small representative
sample over exhaustive configuration catalogs.

## Git Workflow

Use Conventional Commits, and write commit messages in English.

Do not create pull requests by default.

For small changes, commit directly on the default branch. For larger changes,
create a short-lived branch, finish the work there, merge it back into the
default branch locally, then push.

## Documentation

Prefer SSOT. When a detail already lives in config, scripts, CI definitions, or
source files, docs should point to that authority instead of restating volatile
implementation detail.

- `README.md`: human-facing entry point, overview, setup, and a small amount of
  stable operational guidance.
- `ARCHITECTURE.md`: repository structure, runtime behavior, and stable system
  contracts shared by humans and agents.
- `DEVELOPMENT.md`: shared development workflow, verification, documentation
  boundaries, and git conventions.
- `AGENTS.md`: agent-specific operating constraints and editing guidance.
