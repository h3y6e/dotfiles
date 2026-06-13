#!/bin/bash

set -Eeufo pipefail

mise bootstrap packages upgrade -y
mise upgrade
