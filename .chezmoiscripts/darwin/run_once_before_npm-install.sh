#!/bin/bash

set -Eeufo pipefail

if ! type github-copilot-cli &>/dev/null; then
  echo "installing github-copilot-cli..."
  npm install -g @githubnext/github-copilot-cli
  github-copilot-cli auth
fi
