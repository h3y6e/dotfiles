#!/bin/bash
# vim: set ft=bash:

set -Eeufo pipefail

if ! command -v mise >/dev/null 2>&1; then
  printf "\033[3;35m%s\033[m\n" "mise installing..."
  curl https://mise.run | sh
fi
