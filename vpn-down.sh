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

if [[ -f "$BASE_DIR/sshuttle.pid" ]]; then
  SSHUTTLEPID=$(cat "$BASE_DIR/sshuttle.pid")
else
  SSHUTTLEPID=$(pgrep sshuttle)
fi
if [ -n "$SSHUTTLEPID" ]; then
  echo "Stopping running sshuttle instance with PID $SSHUTTLEPID"
  kill "$SSHUTTLEPID"
fi

source .vmname
ssh -F .ssh_config_vagrant "$VMNAME" "/vagrant/connect.sh down"

if which notify-send > /dev/null; then
  notify-send -t 3000 -i call-stop "VPN status" "stopped forwarding traffic to VPN VM $VMNAME"
fi
