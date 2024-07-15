#!/usr/bin/env bash


_git_branch_completions() {
  local cur prev branches line
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  case "${cur}" in
    -*)
      # specify switches.
      COMPREPLY=( $(compgen -W '-t -b -m --set-upstream-to' -- $cur))
      return 0
      ;;
  esac
  case "${prev}" in
    -t|-b|branch|checkout)
      # Specify only the local branches.
      branches=$(git branch | sed -e 's/*//')
      COMPREPLY=( $(compgen -W "${branches}" -- ${cur}) )
      return 0
      ;;
    git)
      # Specify git subcommands.
      COMPREPLY=( $(compgen -W "add branch checkout commit rebase rm" -- ${cur}))
      ;;
    *)
      # anything else, fall back to filenames to auto-complete.
      COMPREPLY=( $(compgen -f -- ${cur}))
      ;;
  esac
}

complete -F _git_branch_completions git
