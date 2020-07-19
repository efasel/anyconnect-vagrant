#!/usr/bin/env bash

set -euo pipefail

vagrant ssh --command "/opt/cisco/anyconnect/bin/vpn -s state"

SSHUTTLEPID=$(pgrep sshuttle || true)
if [ -n "$SSHUTTLEPID" ]; then
  echo "traffic is being forwarded (sshuttle is running, PID: $SSHUTTLEPID)"
else
  echo "traffic is not being forwarded"
fi
