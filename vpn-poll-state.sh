#!/usr/bin/env bash

# "Unofficial Bash Strict Mode"
# see http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

readonly BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$BASE_DIR"

while (true); do
  date --iso=seconds
  ./vpn-state.sh
  echo " "
  sleep 60
done
