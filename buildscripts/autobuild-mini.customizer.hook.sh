#!/bin/bash

echo "BCOS: Updating package lists..."
apt update
apt list --upgradable
echo "BCOS: Enabling squid-deb-proxy-client for local network..."
apt install squid-deb-proxy-client -y
# echo "BCOS: Installing git."
# apt-get install -y --no-install-recommends git
# echo "BCOS: Configuring git."
# git config --global user.email "kamilion@gmail.com"
# git config --global user.name "Graham Cantin"
# git config --global push.default simple
# mkdir -p /home/git
# cd /home/git
# echo "BCOS: Checking out kamikazi-core repository..."
# git clone https://kamilion@github.com/kamilion/kamikazi-core.git --depth=1
# echo "BCOS: Attempting to rebuild ISO contents..."
# cd /home/git/kamikazi-core/buildscripts/bionic/
# git pull
echo "BCOS: Updating packages to current..."
# Work around annoying recommends (fonts-droid-fallback)
apt-get install -y --no-install-recommends libgs9-common 
# Do the upgrade
apt full-upgrade -y
apt-get autoremove --purge -y
echo "BCOS: Running builder script..."
./00-build-minilubuntu-iso-from-source.sh
apt-get autoremove --purge -y
echo "BCOS: Autobuild complete."
exit 0
