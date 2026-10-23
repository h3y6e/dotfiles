#!/bin/bash

set -Eeufo pipefail

export PATH="${HOME}/.local/bin:${PATH}"

mise upgrade
mise bootstrap packages upgrade --yes
mise x -- sheldon lock --update
