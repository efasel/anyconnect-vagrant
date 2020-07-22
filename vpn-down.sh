#!/usr/bin/env bash

set -euo pipefail

IFS=$'\n\t'

if [ ! -f ".vmname" ]; then
  echo "VM not running?"
  exit 1
fi

SSHUTTLEPID=$(pgrep sshuttle)
if [ -n "$SSHUTTLEPID" ]; then
  echo "Stopping running sshuttle instance with PID $SSHUTTLEPID"
  kill "$SSHUTTLEPID"
fi

source .vmname
ssh -F .ssh_config_vagrant "$VMNAME" "/vagrant/connect.sh down"
