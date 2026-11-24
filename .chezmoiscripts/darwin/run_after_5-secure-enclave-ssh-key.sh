#!/bin/bash

set -Eeufo pipefail

cd ~/.ssh
key=id_ecdsa_sk_rk_ssh gh="${HOME}/.local/share/mise/shims/gh" scope=admin:ssh_signing_key

if [[ ! -f $key ]]; then
  (($(sc_auth list-ctk-identities | grep -c .) == 1)) || {
    echo "CTK identity already exists" >&2
    exit 1
  }
  sc_auth create-ctk-identity -l ssh -k p-256-ne -t none
  ssh-keygen -K -w /usr/lib/ssh-keychain.dylib -N "" </dev/null
fi

"$gh" api users/h3y6e/ssh_signing_keys --jq '.[].key' | grep -qF "$(cut -d' ' -f2 "$key.pub")" && exit 0

if ! "$gh" auth status 2>&1 | grep -q "$scope" && "$gh" auth refresh -s "$scope"; then
  trap '"$gh" auth refresh -r "$scope" || true' EXIT
fi
"$gh" ssh-key add "$key.pub" --type signing
