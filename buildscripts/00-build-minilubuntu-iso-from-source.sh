#!/bin/bash
OLDDIR=${PWD}

echo "[BCOS-build] Building Clean minilubuntu ISO from lubuntu-18.04-amd64.iso"
apt-get install -y gdebi-core
echo "[BCOS-build] Replacing firefox with qupzilla."
packages=$(awk '{print $1} ' 01-add-replacement-browser.synpkg)
apt-get install -y ${packages}
sleep 2
./01-add-replacement-browser.sh
sleep 2
echo "[BCOS-build] Removing application packages."
packages=$(awk '{print $1} ' 02-purgelist.synpkg)
apt-get purge -y ${packages}
sleep 2
echo "[BCOS-build] Removing application library packages."
packages=$(awk '{print $1} ' 03-purgelist.synpkg)
apt-get purge -y ${packages}
sleep 2
echo "[BCOS-build] Removing system library packages."
packages=$(awk '{print $1} ' 04-purgelist.synpkg)
apt-get purge -y ${packages}
sleep 2
echo "[BCOS-build] Removing media packages."
packages=$(awk '{print $1} ' 05-purgelist.synpkg)
apt-get purge -y ${packages}
sleep 2
packages=$(awk '{print $1} ' 01-add-replacement-browser.synpkg)
apt-get install -y ${packages}
sleep 2
echo "[BCOS-build] Adding base console packages."
packages=$(awk '{print $1} ' 11-addlist-console.synpkg)
echo ${packages}
apt-get install -y ${packages}
sleep 2
echo "[BCOS-build] Adding open-vm-tools packages."
packages=$(awk '{print $1} ' 12-addlist-openvmtools.synpkg)
echo ${packages}
apt-get install -y ${packages}
sleep 2
#echo "[BCOS-build] Adding base server packages."
#packages=$(awk '{print $1} ' 13-addlist.synpkg)
#echo ${packages}
#apt-get install -y ${packages}
#sleep 2
# Remove chronyd's pidfile.
rm -f /run/chronyd.pid
apt-get purge -y ntp
sleep 2
# Customizer will detect there is no kernel and install linux-image-generic.
echo "[BCOS-build] Removing kernel packages."
apt-get purge -y linux-image* linux-headers* linux-modules*
sleep 2

echo "[BCOS-build] Cleaning up..."
### Begin cleaning up the filesystem
# Remove this socket that causes unpacking squashfs to warn.
rm -f /run/synaptic.socket

echo "[BCOS-build] Ready to Build ISO."
