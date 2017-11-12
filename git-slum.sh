#! /usr/bin/env bash

renamed=()
modified=()
added=()
deleted=()

actions=()

listoff () {
  case "$#" in
  0)
    # do nothing
    ;;
  1)
    printf "%s\n" "$1"
    ;;
  2)
    printf "%s and %s\n" "$1" "$2"
    ;;
  *)
    printf "%s, " "${@:1:$#-1}"
    printf "and %s\n" "${!#}"
    ;;
  esac
}

while IFS=$'\t' read -r status src dst; do
  case "$status" in
    R*)
      renamed+=("$src to $dst")
      if [[ "${status:1}" != "100" ]]; then
        modified+=("$dst")
      fi
      ;;
    M)
      modified+=("$src")
      ;;
    A)
      added+=("$src")
      ;;
    D)
      deleted+=("$src")
      ;;
  esac
done < <(git diff --name-status "$@")

append-action () {
  if [[ "$#" > 1 ]]; then
    local action
    if [[ "${#actions[@]}" == 0 ]]; then
      action=${1^}
    else
      action=$1
    fi
    shift
    actions+=("$(printf "%s " "$action" && listoff "$@")")
  fi
}

append-action rename "${renamed[@]}"
append-action update "${modified[@]}"
append-action create "${added[@]}"
append-action delete "${deleted[@]}"

listoff "${actions[@]}"
