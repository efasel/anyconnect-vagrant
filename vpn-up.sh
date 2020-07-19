#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

VM_STATUS=$(vagrant status --machine-readable | grep ",state,"  | awk -F, '{print $4}')
if [ "$VM_STATUS" != "running" ]; then
  echo "please first log in into the VM: ./vm-login.sh"
  exit 1
fi

vagrant ssh-config > .ssh_config_vagrant
VMNAME=$(vagrant status --machine-readable | head -n 1 | awk -F, '{ print $2 }')
ssh -F .ssh_config_vagrant "$VMNAME" "/vagrant/connect.sh up"

echo "setting up traffic forwarding"
./forward.sh
