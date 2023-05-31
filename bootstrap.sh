#!/bin/bash

#
# Test platforms: RHEL 6, 7, Ubuntu 16.04, 18.04, SuSE 12
# To keep it simple, this script doesn't install any package that
# should usually be installed via package manager for the distribution
#

set -e

set_log_color() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    MAGENTA="$(tput setaf 5)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    MAGENTA=""
    BOLD=""
    NORMAL=""
  fi
}

info() {
  printf "${MAGENTA}$1${NORMAL}"
}

warn() {
  printf "${YELLOW}$1${NORMAL}"
}

success() {
  printf "${GREEN}$1${NORMAL}"
}

main() {
  DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  if [ ${UID-notset} = "notset" ]; then
    UID=$(id -u)
  fi

  info "stow...\n"
  if command -v stow >/dev/null 2>&1; then
    STOW="stow"
  elif command -v xstow >/dev/null 2>&1; then
    STOW="xstow"
  else
    warn "command stow or xstow not found!\n"
    exit 1
  fi

  $STOW -v -t ~ -d $DOT_ROOT dircolors emacs git tmux vim zsh
  if [ "$(uname)" == "Linux" ]; then
    $STOW -v -t ~ -d $DOT_ROOT x i3 urxvt dunst
  fi
  success "[DONE]\n"
  success "Please re-login to take effect.\n"
}

set_log_color
main $@
