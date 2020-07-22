#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

echo -n "checking if VM is running: "
VM_STATUS=$(vagrant status --machine-readable | grep ",state,"  | awk -F, '{print $4}')
if [ "$VM_STATUS" != "running" ]; then
  echo "NO"
  echo "please first log in into the VM: ./vm-login.sh"
  exit 1
else
  echo "OK"
fi

source .vmname
ssh -F .ssh_config_vagrant "$VMNAME" "/vagrant/connect.sh up"

echo "setting up traffic forwarding"
./forward.sh
