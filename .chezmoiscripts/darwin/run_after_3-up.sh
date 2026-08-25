#!/bin/bash

set -Eeufo pipefail

export PATH="${HOME}/.local/bin:${PATH}"

printf "\033[3;35m%s\033[m\n" "mise updating..."
mise self-update -y
mise upgrade
mise bootstrap packages upgrade --yes
mise x -- sheldon lock --update
