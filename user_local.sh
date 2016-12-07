#!/bin/bash

SNAME=$1
IP=$2
UNAME=$3
NEWPWD=$4

ssh-keygen -t rsa -b 4096 -C "$SNAME $IP" -f "~/.ssh/id_rsa_$SNAME" -N ${NEWPWD}
scp ~/.ssh/id_rsa_$SERVERNAME.pub ${UNAME}@${IP}:

ssh -t -t -i ~/.ssh/id_rsa_$SERVERNAME ${UNAME}@${IP}
