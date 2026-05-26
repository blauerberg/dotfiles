setopt interactivecomments
setopt nonomatch
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

export KEYTIMEOUT=100
export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
export HISTSIZE="${HISTSIZE:-1000000}"
export SAVEHIST="${SAVEHIST:-1000000}"
export HISTORY_IGNORE="${HISTORY_IGNORE:-"(ls|ls -al|ls -ltr|date|pwd|exit|clear|git log|git log -p|git status|git diff|git lg)"}"

typeset -U path PATH

for dir in \
  "$HOME/.local/bin" \
  "$HOME/.devcontainers/bin" \
  "$HOME/.docker/bin" \
  /opt/homebrew/bin \
  /usr/local/bin \
  /opt/homebrew/opt/coreutils/libexec/gnubin
do
  if [[ -d "$dir" ]]; then
    path=("$dir" $path)
  fi
done
