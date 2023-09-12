#!/bin/bash

set -Eeufo pipefail

printf "\033[3;35m%s\033[m\n" "npm installing..."

if ! type github-copilot-cli &>/dev/null; then
  echo "installing github-copilot-cli..."
  npm install -g @githubnext/github-copilot-cli
  github-copilot-cli auth
fi

if ! type ncu &>/dev/null; then
  echo "installing ncu..."
  npm install -g npm-check-updates
fi
