#!/bin/bash

set -Eeufo pipefail

export PATH="${HOME}/.local/bin:${PATH}"

mise upgrade
mise skills sync --global
mise bootstrap packages upgrade --yes
mise x -- sheldon lock --update

brew upgrade --cask wezterm@nightly --greedy-latest
