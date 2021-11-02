# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # base box: Ubuntu 20.04 LTS (Focal Fossa)
  config.vm.box = "ubuntu/focal64"

  vmhostname = "vpn-anyconnect"
  config.vm.define vmhostname # name in Vagrant (instead of "default")
  config.vm.hostname = vmhostname # name of host inside the VM, i.e. `/etc/hostname`

  config.vm.provider "virtualbox" do |vb|
    vb.name = vmhostname # name in virtualbox
    vb.memory = 1024
    vb.cpus = 1

    # we need this fix, see [Bug #1829625 “Vagrant box startup timeout due to no serial port” : Bugs : cloud-images](https://bugs.launchpad.net/cloud-images/+bug/1829625)
    vb.customize ["modifyvm", :id, "--uart1", "0x3F8", "4"]
    vb.customize ["modifyvm", :id, "--uartmode1", "file", File::NULL]
  end

  # and finally provision the VM with the shell script "install.sh"
  config.vm.provision :shell, path: "install.sh"
end
