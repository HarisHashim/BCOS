#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
else

  # echo "[BCOS-build] Setting this node up to be an ISO builder..."
  # apt-get install --no-install-recommends -y git gksu build-essential fakeroot make binutils g++ squashfs-tools xorriso x11-xserver-utils xserver-xephyr qemu-kvm dpkg-dev debhelper 
  # apt-get install --no-install-recommends -y python python-dev python-qt5 
  # apt-get install --no-install-recommends -y python3 python3-dev python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools qt5-default

  parentdir=`echo $(cd ../ && pwd)`
  mkdir -p `echo $parentdir/work`
  sed -i -e 's:{WORKDIR}:'`echo $parentdir`/work':' customizer-mini.conf 
  sed -i -e 's:{SCRIPTDIR}:'`pwd`':' customizer-mini.conf 

  if [ ! -f `echo $parentdir/work/lubuntu-18.04.1-desktop-amd64.iso` ]; 
    then echo "[BCOS-build] Downloading ISO to work directory.";
    wget http://cdimage.ubuntu.com/lubuntu/releases/18.04/release/lubuntu-18.04.1-desktop-amd64.iso -P `echo $parentdir/work`;
  fi


  if [ ! -f `echo $parentdir/work/code_1.31.1-1549938243_amd64.deb` ]; 
    then echo "[BCOS-build] Downloading VSCode deb installer to work directory.";
    wget https://az764295.vo.msecnd.net/stable/1b8e8302e405050205e69b59abb3559592bb9e60/code_1.31.1-1549938243_amd64.deb -P `echo $parentdir/work`;
  fi

  echo "[BCOS-build] This node is now an ISO builder."
  echo "[BCOS-build] Open a terminal, navigate to this directory."
  echo "[BCOS-build] Run mini-rebuild.sh then build.sh."

