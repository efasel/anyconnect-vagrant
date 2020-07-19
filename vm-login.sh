#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

VM_STATUS=$(vagrant status --machine-readable | grep ",state,"  | awk -F, '{print $4}')
if [ "$VM_STATUS" != "running" ]; then
  echo "starting VM"
  vagrant up
else
  echo "VM already running"
fi

echo "Now logging in into the VM. Remember to stay logged in, otherwise VPN connection will be automatically terminated!"
vagrant ssh
