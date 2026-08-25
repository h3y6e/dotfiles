#!/usr/bin/env bash

set -Eeufo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]:-install.sh}") [options]

Install dotfiles.

Available options:

-h, --help     Print this help and exit
-v, --verbose  Print script debug info
--no-color     No colors
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' GREEN='\033[0;32m' BLUE='\033[0;34m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' GREEN='' BLUE='' YELLOW=''
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
  while :; do
    case "${1-}" in
    -h | --help) usage;;
    -v | --verbose) set -x;;
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
  if ! mise="$(command -v mise)"; then
    mise="${HOME}/.local/bin/mise"
    info "Installing mise to '${mise}'"
    if has "curl"; then
      mise_install_script="$(curl -fsLS https://mise.run)"
    elif has "wget"; then
      mise_install_script="$(wget -qO- https://mise.run)"
    else
      die "curl or wget required."
    fi
    sh -c "${mise_install_script}"
    unset mise_install_script
  fi

  info "Installing dotfiles..."
  # run from a checkout: apply it as the source; run via `curl | bash`: clone from GitHub
  if [[ -f "${BASH_SOURCE[0]-}" ]]; then
    script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
    "${mise}" x chezmoi -- chezmoi init --apply --source="${script_dir}"
  else
    "${mise}" x chezmoi -- chezmoi init --apply h3y6e
  fi

  completed "All done."
  return 0
}

parse_params "$@"
setup_colors
install
