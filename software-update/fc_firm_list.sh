#!/bin/sh
find /etc/aerofc/ -name *.px4 
mount /dev/sda1 /mnt
mkdir /temp_fc_fm
cp /mnt/*.px4 /temp_fc_fm
umount /mnt
ls /temp_fc_fm/ 

