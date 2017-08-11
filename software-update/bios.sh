#!/bin/sh
echo "Current BIOS Version"
aero-get-version.py | grep "BIOS_VERSION"
mount /dev/sda1 /mnt
mkdir /temp_bios
cp /mnt/capsule*.rpm /temp_bios
umount /mnt
rpm -ivh /temp_bios/capsule*.rpm
ret_code=$?
  if [ $ret_code != 0 ]; then
    printf "\nError : [%d] when executing command: '$cmnd'" $ret_code
    rm -rf /temp_bios
    exit $ret_code
  fi
rm -rf /temp_bios
echo "RPM done"
reboot

