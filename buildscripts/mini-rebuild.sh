#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
else

cp customizer-mini.conf /etc/customizer.conf
echo "BCOS-rebuild: Cleaning up previous run..."
customizer -t
echo "BCOS-rebuild: Extracting ISO..."
customizer -e
echo "BCOS-rebuild: Triggering custom hook..."
customizer -k
echo "BCOS-rebuild: Removing WUBI from ISO..."
rm -f /home/haris/dev/BCOS/work/ISO/wubi.exe
rm -f /home/haris/dev/BCOS/work/ISO/autorun.inf
rm -Rf /home/haris/dev/BCOS/work/ISO/pics/
echo "BCOS-rebuild: Removing package pool from ISO..."
rm -Rf /home/haris/dev/BCOS/work/ISO/dists/
rm -Rf /home/haris/dev/BCOS/work/ISO/pool/
echo "BCOS-rebuild: Clearing annoyances from filesystem..."
rm -Rf /home/haris/dev/BCOS/work/FileSystem/home/git
rm -Rf /home/haris/dev/BCOS/work/FileSystem/var/cache/apt/archives
mkdir -p /home/haris/dev/BCOS/work/FileSystem/var/cache/apt/archives/partial
echo "BCOS-rebuild: Clearing apport crash reports from filesystem..."
rm -f /home/haris/dev/BCOS/work/FileSystem/var/crash/*

echo "BCOS-rebuild: Installing deb package"
customizer -d

echo "BCOS-rebuild: Building output ISO..."
customizer -r

echo "BCOS-rebuild: Finalizing output ISO..."
if [ ! -f `echo $parentdir/work/Ubuntu-amd64-18.04.iso` ]; 
  then echo "[BCOS-build] Copying ISO to BCOS directory.";
  cp `echo $parentdir/work/Ubuntu-amd64-18.04.iso` ../bcos-amd64-18.04.iso;
fi

echo "BCOS-rebuild: Complete."
exit 0
fi
