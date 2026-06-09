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

if echo "$1" | grep -q '[ぁ-んァ-ン一-龯]'; then
  read -r src code dst dcode <<<"Japanese ja English en"
else
  read -r src code dst dcode <<<"English en Japanese ja"
fi

mise x -- ollama run translategemma "You are a professional $src ($code) to $dst ($dcode) translator. Your goal is to accurately convey the meaning and nuances of the original $src text while adhering to $dst grammar, vocabulary, and cultural sensitivities.
Produce only the $dst translation, without any additional explanations or commentary. Please translate the following $src text into $dst:


$1" 2>|/dev/null
