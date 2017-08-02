import os
import pexpect
import subprocess
import logging
import json

f = open('/usr/share/cockpit/network/output.txt', "w")
connmanctl=pexpect.spawn('connmanctl')
connmanctl.sendline('tether wifi off')
connmanctl.expect(['disabled','Disabling'])
print connmanctl.before
connmanctl.sendline('agent on')
err=connmanctl.expect(['Agent registered', 'Error'])
if err == 1:
    print 'Error in agent on'
for i in range(1,5):
    connmanctl.sendline('scan wifi')
    err=connmanctl.expect(['Scan completed for wifi', 'Error'])
    if err == 1:
        print 'Error in Scan'
        quit()
    connmanctl.sendline('services')
    out=connmanctl.before
for row in out.split('\n'):
    row=row.rstrip()
    if row != '':
        if 'connmanctl' not in row:
            f.write(row)
            f.write('\n')
f.close()
