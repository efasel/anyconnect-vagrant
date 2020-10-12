#!/usr/bin/env bash

# "Unofficial Bash Strict Mode"
# see http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

readonly BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$BASE_DIR"

if [ ! -f ".vmname" ]; then
  echo "VM not running?"
  exit 1
fi

source .vmname
echo "VM:    $VMNAME"
VPNSTATE=$(ssh -F .ssh_config_vagrant "$VMNAME" "/opt/cisco/anyconnect/bin/vpn state | grep -m 1 -o 'state:.*' | sed -e 's/state: //'")
echo "VPN:   $VPNSTATE"

SSHUTTLEPID=$(pgrep sshuttle || true)
if [ -n "$SSHUTTLEPID" ]; then
  echo "proxy: sshuttle is running, PID: $SSHUTTLEPID"
  if [ "$VPNSTATE" = "Disconnected" ]; then
    echo "Stopping running sshuttle instance with PID $SSHUTTLEPID"
    kill "$SSHUTTLEPID"
  fi
else
  echo "proxy: sshuttle is not running"
  if [ "$VPNSTATE" = "Connected" ]; then
    echo "starting sshuttle"
    ./forward.sh
  fi
fi
