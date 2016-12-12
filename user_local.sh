#!/bin/bash

IP=$1
SUBDOMAIN=$2
UNAME=$3
NEWPWD=$4

if [[ -z $IP || -z $SUBDOMAIN || -z $UNAME || -z $NEWPWD ]]; then
        echo Usage...
        exit 1
fi

ssh-keygen -t rsa -b 4096 -C "${IP}" -f ~/.ssh/id_rsa_${SUBDOMAIN} -N ${NEWPWD}
scp -o PubkeyAuthentication=no ~/.ssh/id_rsa_${SUBDOMAIN}.pub ${UNAME}@${IP}:~/.ssh/authorized_keys

echo ssh -i ~/.ssh/id_rsa_$$ ${UNAME}@${IP}
