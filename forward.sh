#!/bin/bash

vagrant ssh-config > .ssh_config_vagrant
/usr/local/bin/sshuttle --dns -r default 10.0.0.0/8 --ssh-cmd "ssh -F .ssh_config_vagrant" --daemon
