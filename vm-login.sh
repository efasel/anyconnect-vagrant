#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# make sure VM is running
VM_STATUS=$(vagrant status --machine-readable | grep ",state,"  | awk -F, '{print $4}')
if [ "$VM_STATUS" != "running" ]; then
  echo "starting VM"
  vagrant up

  # write config for subsequent scripts
  echo "export VMNAME=$(vagrant status --machine-readable | head -n 1 | awk -F, '{ print $2 }')" > .vmname
  vagrant ssh-config > .ssh_config_vagrant
else
  echo "VM already running"
fi

echo "Now logging in into the VM. Remember to stay logged in, otherwise VPN connection will be automatically terminated!"
source .vmname
ssh -F .ssh_config_vagrant "$VMNAME"
