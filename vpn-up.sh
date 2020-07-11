#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

if [[ -z "${1:-}" || -z "${2:-}" || -z "${3:-}" ]]; then
    echo "Error: you must provide VPN profile name, username and password as arguments!"
    exit 1
fi

VM_STATUS=$(vagrant status --machine-readable | grep ",state,"  | awk -F, '{print $4}')
if [ "$VM_STATUS" != "running" ]; then
  vagrant up
fi

vagrant ssh-config > .ssh_config_vagrant
VMNAME=$(vagrant status --machine-readable | head -n 1 | awk -F, '{ print $2 }')
ssh -F .ssh_config_vagrant $VMNAME "/vagrant/connect.sh up $1 $2 $3"

echo "setting up traffic forwarding"
./forward.sh
