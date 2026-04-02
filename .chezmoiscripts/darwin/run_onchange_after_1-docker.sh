#!/bin/bash

set -Eeufo pipefail

CONFIG_PATH="${HOME}/.docker/config.json"

if command -v jq > /dev/null; then
  printf "\033[3;35m%s\033[m\n" "setting up docker..."
  mkdir -p "$(dirname "$CONFIG_PATH")"
  (cat "$CONFIG_PATH" 2>/dev/null || echo '{}') \
    | jq '.cliPluginsExtraDirs |= (. + ["/opt/homebrew/lib/docker/cli-plugins"] | unique)' \
    > "${CONFIG_PATH}.tmp" && mv "${CONFIG_PATH}.tmp" "$CONFIG_PATH"
fi
