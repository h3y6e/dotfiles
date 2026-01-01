#!/bin/bash

set -Eeufo pipefail

brew upgrade
brew upgrade --cask --greedy-latest
sheldon lock --update
mise upgrade
