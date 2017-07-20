#!/bin/bash

set -e

SSID=$1
PASSWORD=$2

ret=$(/usr/bin/connmanctl enable wifi || true)
if !([[ "$ret" == *"Enabled"* || *"enabled"* ]]); then
	echo "Error in enabling wifi"
	exit 1
fi

if(/usr/bin/connmanctl tether wifi $SSID $PASSWORD 2>&1 | grep 'Error'); then
	echo "Error in changing SSID or password"
	exit 1
fi

ret=$(/usr/bin/connmanctl tether wifi off 2>&1)
if !([[ "$ret" == *"Disabled"* || *"disabled"* ]]); then
        exit 1
fi

retries=5
while [ $retries -gt 0 ]; do
	ret=$(/usr/bin/connmanctl tether wifi on 2>&1)
	if [[ "$ret" != *"Not supported"* ]]; then
		echo $ret
		break
	fi
	sleep 1
	retries=$((retries - 1))
done

if [ $retries -gt 0 ]; then
	echo "Configuration Successfull"
else
	exit 1
fi
