#!/usr/bin/env bash

set -euo pipefail

IFS=$'\n\t'

SSHUTTLEPID=$(pgrep sshuttle)
if [ -n "$SSHUTTLEPID" ]; then
  echo "Stopping running sshuttle instance with PID $SSHUTTLEPID"
  kill "$SSHUTTLEPID"
fi

vagrant ssh --command "/vagrant/connect.sh down"
