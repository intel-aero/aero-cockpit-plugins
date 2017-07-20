#!/bin/bash

bash /usr/sbin/firstboot-connman-setup
ret=$(/usr/bin/connmanctl tether wifi off 2>&1)
if !([[ "$ret" == *"Disabled"* || *"disabled"* ]]); then
	exit 1
fi

sleep 1

ret=$(/usr/bin/connmanctl tether wifi on 2>&1)
if [[ "$ret" != *"Not supported"* ]]; then
	exit 0
else
	exit 1
fi
