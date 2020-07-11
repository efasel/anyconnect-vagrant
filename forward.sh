#!/bin/bash

vagrant ssh-config > .ssh_config_vagrant
VMNAME=$(vagrant status --machine-readable | head -n 1 | awk -F, '{ print $2 }')
/usr/local/bin/sshuttle --dns -r $VMNAME 10.0.0.0/8 --ssh-cmd "ssh -F .ssh_config_vagrant" --daemon
