#!/bin/bash

if [ ! -f ".vmname" ]; then
  echo "VM not running?"
  exit 1
fi

source .vmname
/usr/local/bin/sshuttle --dns -r "$VMNAME" 10.0.0.0/8 --ssh-cmd "ssh -F .ssh_config_vagrant" --daemon
