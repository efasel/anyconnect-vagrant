# About anyconnect-vagrant
This project allows Cisco Anyconnect and Traps/Cortex to run in a VM using Vagrant. 

Currently all DNS traffic is sent through the VPN.

To establish or tear down the VPN connection you can use the following scripts:

## `vpn-up.sh`

e.g. `./vpn-up.sh {username} {password}`

* creates and provisions the VM (only on the first run)
* starts the VM if not running
* establishes the VPN connection
* forwards traffic through the VPN

## `vpn-down.sh`

e.g. `./vpn-down.sh`

* stop forwarding of the traffif
* tear down the VPN connection

## `vpn-state.sh`

* check the current state of the VPN connection

## Dependencies

* sshuttle

Ubuntu: you might need to compile your own up-to-date version of sshuttle and specify the path to that binary 
in `forward.sh`

## To configure

* Obtain the AnyConnect linux installer program. Place in the file 'packages/anyconnect.tar.gz'
* Obtain the "Traps/Cortex" debian linux installer. Place in the file 'packages/cortex.deb' directory. 
* The routes which forwarded through the VPN are currently hardcoded in `forward.sh`

## Disclaimer

This project is for informational use only. Do not use it to bypass your company procedures or security policies. 
Use at your own risk. I can offer no support for this project. 
