# About anyconnect-vagrant
This project allows Cisco Anyconnect and Traps/Cortex to run in a VM using Vagrant. 

Currently, all DNS traffic is sent through the VPN.

To establish or tear down the VPN connection you can use the following scripts:

## `vpn-up.sh`

e.g. `./vpn-up.sh {username} {password}`

* creates and provisions the VM (only on the first run)
* starts the VM if not running
* establishes the VPN connection
* forwards traffic through the VPN

## `vpn-down.sh`

e.g. `./vpn-down.sh`

* stop forwarding of the traffic
* tear down the VPN connection

## `vpn-state.sh`

* check the current state of the VPN connection

## Dependencies

### Vagrant

The VM is created and configured via Vagrant. Download it here: [Downloads | Vagrant by HashiCorp](https://www.vagrantup.com/downloads.html)

### VirtualBox

The VM runs in VirtualBox. Download it here:

* [Downloads – Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [VirtualBox 6.1.10 Oracle VM VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads#VirtualBox6.1.10OracleVMVirtualBoxExtensionPack)

### sshuttle

* [sshuttle/sshuttle: Transparent proxy server that works as a poor man's VPN. Forwards over ssh. Doesn't require admin. Works with Linux and MacOS. Supports DNS tunneling.](https://github.com/sshuttle/sshuttle)

**Ubuntu**: you need to compile your own up-to-date version of sshuttle and specify the path to that binary 
in `forward.sh`

## To configure

* Obtain the AnyConnect linux installer program. Place in the file 'packages/anyconnect.tar.gz'
* Obtain the "Traps/Cortex" debian linux installer. Place in the file 'packages/cortex.deb' directory. 
* The routes which forwarded through the VPN are currently hardcoded in `forward.sh`

## Disclaimer

This project is for informational use only. Do not use it to bypass your company procedures or security policies. 
Use at your own risk. I can offer no support for this project. 
