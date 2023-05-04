#!/bin/bash

set -Eeufo pipefail

file="/etc/pam.d/sudo"
if ! grep 'pam_tid.so' ${file} > /dev/null; then
  echo "setting up pam..."
  sudo sed -i "" '2i\
auth       sufficient     pam_tid.so # add by chezmoiscripts
  ' ${file}
fi
