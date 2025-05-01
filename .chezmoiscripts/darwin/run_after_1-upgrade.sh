#!/bin/bash

set -Eeufo pipefail

brew upgrade
sheldon lock --update
mise upgrade
