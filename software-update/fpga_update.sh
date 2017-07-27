#!/bin/sh
jam -aprogram /etc/fpga/$1
ret_code=$?
  if [ $ret_code != 0 ]; then
    printf "Error : [%d] when executing command: '$cmnd'" $ret_code
    rm -rf /temp_fc_fm
    exit $ret_code
  fi
rm -rf /temp_fpga
reboot
