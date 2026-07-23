#!/bin/bash

set -Eufo pipefail

export HOMEBREW_NO_ASK=1

brew upgrade
brew upgrade --cask --greedy-latest

exit 0
