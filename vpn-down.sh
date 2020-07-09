#!/usr/bin/env bash

set -euo pipefail

IFS=$'\n\t'

if [ -f "sshuttle.pid" ]; then
  echo "Stopping running sshuttle instance with PID $(cat sshuttle.pid)"
  kill "$(cat sshuttle.pid)"
fi

vagrant ssh --command "/vagrant/connect.sh down"
