#!/bin/bash

set -Eeufo pipefail

export HOMEBREW_NO_ASK=1

brew upgrade
brew upgrade --cask --greedy-latest
mise bootstrap packages upgrade -y
mise upgrade
sheldon lock --update
