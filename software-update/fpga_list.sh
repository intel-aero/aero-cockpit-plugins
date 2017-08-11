#!/bin/sh
ls /etc/fpga/
mount /dev/sda1 /mnt
mkdir /temp_fpga
cp /mnt/*.jam /temp_fpga
umount /mnt
ls /temp_fpga/ 
