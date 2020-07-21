#!/bin/bash

set -euo pipefail
set -x

apt-get update && apt-get --assume-yes --no-install-recommends install ca-certificates network-manager libsecret-tools

# Cortex
apt install /vagrant/packages/cortex.deb

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
