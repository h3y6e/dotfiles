#!/usr/bin/env bash

set -Eeufo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Translate ja <-> en
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🌐
# @raycast.argument1 { "type": "text", "placeholder": "text (ja/en)" }

# Documentation:
# @raycast.author h3y6e
# @raycast.authorURL https://raycast.com/h3y6e

export MISE_EXEC_AUTO_INSTALL=0
text="$1"

if mise x -- rg -q '\p{Hiragana}|\p{Katakana}|\p{Han}' <<<"$text"; then
  read -r src dst <<<"Japanese English"
else
  read -r src dst <<<"English Japanese"
fi

prompt="Translate the following $src text into $dst.

$text"

# shellcheck disable=SC2016
body=$(mise x -- jq -n --arg prompt "$prompt" \
  '{model: "mradermacher/CAT-Translate-7b-i1-GGUF:Q4_K_M", messages: [{role: "user", content: $prompt}]}')

curl -sf http://127.0.0.1:11435/v1/chat/completions \
  -H 'Content-Type: application/json' \
  -d "$body" | mise x -- jq -r '.choices[0].message.content'
