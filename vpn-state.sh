#!/usr/bin/env bash

set -euo pipefail

vagrant ssh --command "/opt/cisco/anyconnect/bin/vpn -s state"

if [ -f "sshuttle.pid" ]; then
  SHUTTLEPID=$(cat sshuttle.pid)
  if [ -n "$(ps -p $SHUTTLEPID)" ]; then
    echo "traffic is being forwarded (sshuttle is running)"
  else
    echo "traffic is being forwarded (sshuttle is running)"
  fi

fi
