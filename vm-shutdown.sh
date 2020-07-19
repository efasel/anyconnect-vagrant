#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

if [ -f "sshuttle.pid" ]; then
  echo "Stopping running sshuttle instance with PID $(cat sshuttle.pid)"
  kill "$(cat sshuttle.pid)"
fi

VM_STATUS=$(vagrant status --machine-readable | grep ",state,"  | awk -F, '{print $4}')
if [ "$VM_STATUS" = "running" ]; then
  echo "halting VM"
  vagrant halt
else
  echo "VM not running"
fi
