#!/bin/bash

set -Eeufo pipefail

printf "\033[3;35m%s\033[m\n" "npm installing..."

if ! type github-copilot-cli &>/dev/null; then
  echo "installing github-copilot-cli..."
  npm install -g @githubnext/github-copilot-cli
  github-copilot-cli auth
fi

if ! type npm-check &>/dev/null; then
  echo "installing npm-check..."
  npm install -g npm-check
fi
