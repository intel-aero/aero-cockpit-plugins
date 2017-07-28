#!/bin/bash
cd /var/lib/mavlink-router/logs/
find . -type f -exec ls -lah {} \; 2> /dev/null | sort -k 6,6M -k 7,7n -k 8,8n | awk '{print $9 "\n" $8 $6 $7 "\n" $5}'

