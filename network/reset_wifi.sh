#!/bin/bash

sh /usr/sbin/firstboot-connman-setup
/usr/bin/connmanctl tether wifi off
sleep 1
/usr/bin/connmanctl tether wifi on
