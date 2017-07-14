#!/bin/bash
#!/bin/bash

set -e

FILECONDITION="/etc/sysconfig/connman"
SSID=$1
PASSWORD=$2

mkdir -p $(dirname $FILECONDITION)
/usr/bin/connmanctl enable wifi || true
/usr/bin/connmanctl tether wifi $SSID $PASSWORD
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
