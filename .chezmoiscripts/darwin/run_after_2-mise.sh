#!/bin/bash

set -Eufo pipefail

mise bootstrap packages apply -y
mise bootstrap packages upgrade -y
mise upgrade

exit 0
