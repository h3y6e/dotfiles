#!/bin/bash

set -Eeufo pipefail

printf "\033[3;35m%s\033[m\n" "npm installing..."

if ! type npm-check &>/dev/null; then
  echo "installing npm-check..."
  npm install -g npm-check
fi
