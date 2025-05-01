#!/bin/bash

set -Eeufo pipefail

file="/etc/pam.d/sudo_local"
if [[ ! -f ${file} ]]; then
  printf "\033[3;35m%s\033[m\n" "setting up pam..."
  echo "auth sufficient pam_tid.so" | sudo tee ${file}
fi
