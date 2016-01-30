#
# env
#
export EDITOR=vim
export TERM="xterm-256color"

#
# lang
#
case ${UID} in
0)
  export LANG=C
  ;;
*)
  export LANG=ja_JP.UTF-8
  ;;
esac

#
# prompt
#
setopt transient_rprompt
autoload colors
colors

nprom () {
    setopt prompt_subst
    local lf=$'\n'
    #local branch='[`rprompt-git-current-branch`%~]'
    local rbase="%{${fg[yellow]}%}[%/]%{${reset_color}%}"
    #RPROMPT="%9(~||$branch)"
    local pbase="%{${fg[cyan]}%}%B%n@%m%b: "
    PROMPT="%9(~|$rbase$lf|)$pbase"
}

nprom

#
# completion
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit
zstyle ':completion:*' list-colors ''

#
# alias
#
alias grep="grep --color"
alias ll="ls -al"

case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

#
# terminal
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac

case "${TERM}" in
xterm|xterm-256color)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

case "${TERM}" in
  kterm*|xterm)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

#
# history
#
HISTFILE=~/.zsh_history
HISTSIZE=65535
SAVEHIST=65535
setopt hist_ignore_dups
setopt share_history

#
# key bind
#
#bindkey -v
bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
bindkey "\e[Z" reverse-menu-complete

#
# misc
#
setopt auto_pushd
setopt list_packed
setopt nolistbeep
setopt noautoremoveslash
setopt complete_aliases
setopt nonomatch

# git stash count
function git_prompt_stash_count {
  local COUNT=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
  if [ "$COUNT" -gt 0 ]; then
    echo " ($COUNT)"
  fi
}

setopt prompt_subst
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color action branch

  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi

  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=${fg[green]}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=${fg[yellow]}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=${fg_bold[red]}
  else
    color=${fg[red]}
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  # %{...%} surrounds escape string
  echo "%{$color%}$name%{$reset_color%} "
}

case "${OSTYPE}" in
freebsd*|darwin*|linux*)
    source ~/.zshrc_unix
    ;;
*)
    source ~/.zshrc_windows
    ;;
esac

if [ -f "$HOME/.zshrc_local" ]; then
  source ~/.zshrc_local
fi
