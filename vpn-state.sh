#!/usr/bin/env bash

set -euo pipefail

if [ ! -f ".vmname" ]; then
  echo "VM not running?"
  exit 1
fi

source .vmname
echo "VM:    $VMNAME"
echo "VPN:   $(ssh -F .ssh_config_vagrant "$VMNAME" "/opt/cisco/anyconnect/bin/vpn state | grep -m 1 -o 'state:.*' | sed -e 's/state: //'")"

SSHUTTLEPID=$(pgrep sshuttle || true)
if [ -n "$SSHUTTLEPID" ]; then
  echo "proxy: sshuttle is running, PID: $SSHUTTLEPID"
else
  echo "proxy: sshuttle is not running"
fi
