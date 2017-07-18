#!/bin/bash

set -e

FILECONDITION="/etc/sysconfig/connman"
DEFAULTPASSWORD="1234567890"

while [ 1 ]; do
    read xx MAC xx <<<$(ip link | grep -A1 -e "^[0-9]*: wl" | grep link/ether)
    # poor's man "wait for device to appear"
    if [ -z "$MAC" ]; then
        sleep 1
        continue
    fi

    # remove :
    SSID=${MAC//:}
    # make it uppercase
    SSID=${SSID^^}
    # prefix "Aero-"
    SSID="Aero-$SSID"
    break
done

/usr/bin/connmanctl tether wifi $SSID $DEFAULTPASSWORD
/usr/bin/connmanctl tether wifi off

retries=5
while [ $retries -gt 0 ]; do
    ret=$(/usr/bin/connmanctl tether wifi on 2>&1)
    if [[ "$ret" != *"Not supported"* ]]; then
        echo $ret
        break
    fi
    sleep 1
    retries=$((retries - 1))
    echo "Retry #$((5 - retries))"
done

if [ $retries -gt 0 ]; then
        echo "Configuration Successfull"
fi
