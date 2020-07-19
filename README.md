# About anyconnect-vagrant
This project allows Cisco Anyconnect and Traps/Cortex to run in a VM using Vagrant.

**Please note: you need to stay logged in into the VM as long as you want to use the VPN.
On logout the VPN connection is automatically disconnected!** 

Currently, all DNS traffic is sent through the VPN.

The usual steps you would take are the following:

1. launch the VM, log in **and stay logged in**
1. connect and disconnect the VPN as needed
1. halt the VM

## Configuration

* Obtain the AnyConnect linux installer program. Place in the file 'packages/anyconnect.tar.gz'
* Obtain the "Traps/Cortex" debian linux installer. Place in the file 'packages/cortex.deb' directory. 
* The routes which forwarded through the VPN are currently hardcoded in `forward.sh`
* Create a file `vpnconfig` which contains three lines:
  1. VPN profile name
  1. username
  1. password

## initial usage

This "initial usage" **should** be necessary only once!

1. log in
1. connect manually

### log in

`./vm-login.sh`

### connect manually

Start `/opt/cisco/anyconnect/bin/vpn` and then execute `connect {profile name}` 

## normal usage

### launch the VM, log in and stay logged in

`./vm-login.sh`

* creates and provisions the VM (only on the first run)
* starts the VM if not running
* log in

### connect and disconnect as needed

#### connect to VPN

`./vpn-up.sh`

* establishes the VPN connection
* forwards traffic through the VPN (will ask for root password to do this)

#### check VPN state

`./vpn-state.sh`

* shows status of
  * VPN
  * forwarding

#### disconnect from VPN

`./vpn-down.sh`

* stop forwarding of the traffic
* disconnects from the VPN

### halt the VM

`./vm-shutdown.sh`

* stop forwarding of the traffic
* disconnects from the VPN
* halts the VM

## Troubleshooting

If things go wrong try this:

### `connect.sh`

This script has to be executed on the VM itself. Therefore:

1. `./vm-login.sh`: log in into the VM
1. `/vagrant/connect.sh up`

This establishes the VPN connection. But no traffic is forwarded yet to the VPN.

### `forward.sh`

This script has to be executed locally on the host.

`./forward.sh`

Forward traffic from the host to the VPN. 

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

# Disclaimer

This project is for informational use only. Do not use it to bypass your company procedures or security policies. 
Use at your own risk. I can offer no support for this project. 
