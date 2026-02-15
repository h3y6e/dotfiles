#!/usr/bin/env bash

set -Eeufo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Mask paths
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🙈
# @raycast.argument1 { "type": "text", "placeholder": "log" }

# Documentation:
# @raycast.author h3y6e
# @raycast.authorURL https://raycast.com/h3y6e

echo "$1" | sed -E 's#(/Users)/[^/]+#\1/<user>#g' | sed -E 's#(/ghq/github\.com)/[^/]+/[^/]+#\1/<org>/<repo>#g' | pbcopy
