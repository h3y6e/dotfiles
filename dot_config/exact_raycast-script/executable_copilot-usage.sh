#!/usr/bin/env bash

set -Eeufo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copilot Usage
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 📊

# Documentation:
# @raycast.description Show the current GitHub Copilot usage
# @raycast.author h3y6e
# @raycast.authorURL https://raycast.com/h3y6e

export MISE_EXEC_AUTO_INSTALL=0
export GH_PROMPT_DISABLED=1

mise x -- gh api /copilot_internal/user --jq '
.quota_snapshots.premium_interactions as $q
| (100 - $q.percent_remaining) as $p
| (($p / 5) | floor) as $n
| [
    "GitHub Copilot Usage",
    "",
    "▕\("█" * $n)\("░" * (20 - $n))▏ \($p | floor)%",
    "",
    "Used       \($q.credits_used) / \($q.entitlement)",
    "Remaining  \($q.remaining)",
    "Reset      \(.quota_reset_date)"
  ]
| join("\n")
'
