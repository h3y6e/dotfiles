#!/bin/bash

set -Eufo pipefail

mise self-update -y
mise upgrade

exit 0
