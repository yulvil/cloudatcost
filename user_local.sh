#!/bin/bash

SERVERNAME=$1
IP=$2
UNAME=$3

ssh-keygen -t rsa -b 4096 -c "$SERVERNAME $IP" -f ~/.ssh/id_rsa_$SERVERNAME
scp ~/.ssh/id_rsa_$SERVERNAME.pub ${UNAME}@${IP}:

ssh -i ~/.ssh/id_rsa_$SERVERNAME ${UNAME}@${IP}
