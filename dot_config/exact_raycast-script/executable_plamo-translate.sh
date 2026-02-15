#!/usr/bin/env bash

set -Eeufo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Translate ja <-> en with PLaMo
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🌐
# @raycast.argument1 { "type": "text", "placeholder": "text (ja/en)" }

# Documentation:
# @raycast.author h3y6e
# @raycast.authorURL https://raycast.com/h3y6e

export PATH="$HOME/.local/share/mise/shims:$PATH"

if ! command -v plamo-translate >/dev/null 2>&1; then
  echo >&2 "Error: plamo-translate not found"
  exit 1
fi

plamo-translate --input "$1"
