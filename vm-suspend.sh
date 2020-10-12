#!/usr/bin/env bash

# "Unofficial Bash Strict Mode"
# see http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

readonly BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$BASE_DIR"

if [ -f "sshuttle.pid" ]; then
  echo "Stopping running sshuttle instance with PID $(cat sshuttle.pid)"
  kill "$(cat sshuttle.pid)"
fi

VM_STATUS=$(vagrant status --machine-readable | grep ",state,"  | awk -F, '{print $4}')
if [ "$VM_STATUS" = "running" ]; then
  source .vmname
  echo "suspending VM"
  vagrant suspend

  rm .vmname
  rm .ssh_config_vagrant

  if which notify-send > /dev/null; then
    notify-send -t 3000 -i call-stop "VPN status" "VPN VM $VMNAME is suspended"
  fi
else
  echo "VM not running"
fi
