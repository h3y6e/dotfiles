#!/usr/bin/env bash

set -Eeufo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [options]

Install dotfiles.

Available options:

-h, --help      Print this help and exit
-v, --verbose   Print script debug info
-c, --chezmoi   Only install chezmoi
--no-color      No colors
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

info() {
  msg "${BLUE}>${NOFORMAT} $*"
}

warn() {
  msg "${YELLOW}! $*${NOFORMAT}"
}

completed() {
  msg "${GREEN}✓${NOFORMAT} $*"
}

die() {
  local msg=$1
  local code=${2-1}
  msg "$msg"
  exit "$code"
}

parse_params() {
  only_chezmoi=0

  while :; do
    case "${1-}" in
    -h | --help) usage;;
    -v | --verbose) set -x;;
    -c | --chezmoi) only_chezmoi=1;;
    --no-color) NO_COLOR=1;;
    -?*) die "Unknown option: $1";;
    *) break;;
    esac
    shift
  done

  return 0
}

has() {
  type "$1" > /dev/null 2>&1
}

install() {
  info "install chezmoi..."
  if has "curl" || has "wget"; then
    BIN_DIR="$HOME/.local/bin"
    if has "curl"; then
      sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"
    else
      sh -c "$(wget -qO- get.chezmoi.io)" -- -b "$BIN_DIR"
    fi
  else
    die "curl or wget required."
  fi

  if [[ "$only_chezmoi" == 0 ]]; then
  info "install dotfiles..."
  chezmoi init --apply -S .
  fi

  completed "All done."
  return 0
}

parse_params "$@"
setup_colors
install