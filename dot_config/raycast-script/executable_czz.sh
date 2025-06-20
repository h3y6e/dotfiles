#!/usr/bin/env bash

set -Eeufo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title czz
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⚙️
# @raycast.packageName util

# Documentation:
# @raycast.author h3y6e
# @raycast.authorURL https://raycast.com/h3y6e

zed "$(chezmoi source-path)"
