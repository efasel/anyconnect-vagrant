#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

if [ -f "sshuttle.pid" ]; then
  echo "Stopping running sshuttle instance with PID $(cat sshuttle.pid)"
  kill "$(cat sshuttle.pid)"
fi

VM_STATUS=$(vagrant status --machine-readable | grep ",state,"  | awk -F, '{print $4}')
if [ "$VM_STATUS" = "running" ]; then
  source .vmname
  echo "halting VM"
  vagrant halt

  rm .vmname
  rm .ssh_config_vagrant

  if [ $(which notify-send > /dev/null; echo $?) -eq 0 ]; then
    notify-send -t 3000 -i call-stop "VPN status" "VPN VM $VMNAME is down"
  fi
else
  echo "VM not running"
fi
