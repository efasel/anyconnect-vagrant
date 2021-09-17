#!/bin/bash

set -euo pipefail
set -x

# install packages we need
apt-get update
apt-get --assume-yes --no-install-recommends install ca-certificates network-manager libsecret-tools libgtk2.0-0 libgtk-3-0

# remove some packages we don't need
apt-get --assume-yes ---purge remove alsa-topology-conf alsa-ucm-conf bolt byobu command-not-found cryptsetup cryptsetup-bin cryptsetup-initramfs cryptsetup-run dirmngr dosfstools eatmydata eject ftp fwupd fwupd-signed gdisk git git-man gnupg gnupg-l10n gnupg-utils gpg gpg-agent gpg-wks-client gpg-wks-server gpgconf gpgsm hdparm ltrace lvm2 lxd-agent-loader lz4 mawk mdadm mtr-tiny multipath-tools open-iscsi open-vm-tools os-prober parted patch popularity-contest rsync screen sg3-utils sg3-utils-udev sosreport sound-theme-freedesktop strace tcpdump telnet thin-provisioning-tools tmux whiptail wpasupplicant xauth xfsprogs xxd xz-utils zerofree
apt-get --assume-yes ---purge autoremove

# Cortex
dpkg -i /vagrant/packages/cortex.deb

# AnyConnect
mkdir -p ~/anyconnect
tar xzf /vagrant/packages/anyconnect.tar.gz -C ~/anyconnect --strip-components=1
bash -c "sudo mkdir -p /usr/share/icons/hicolor/{48x48,64x64,96x96,128x128,256x256}/apps /usr/share/desktop-directories /usr/share/applications/"

cd ~/anyconnect/vpn
rm license.txt
./vpn_install.sh

cd ~/anyconnect/posture
./posture_install.sh --no-license --no-prompt

mv /opt/.cisco/certificates/ca /opt/.cisco/certificates/ca.orig
ln -sf /etc/ssl/certs/ /opt/.cisco/certificates/ca
