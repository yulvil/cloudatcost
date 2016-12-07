#!/bin/bash

IP=$1
UNAME=$2
NEWPWD=$3

if [[ -z $IP || -z $UNAME || -z $NEWPWD ]]; then
        echo Usage...
        exit 1
fi

ssh-keygen -t rsa -b 4096 -C "$IP" -f ~/.ssh/id_rsa_$$ -N ${NEWPWD}
scp -o PubkeyAuthentication=no ~/.ssh/id_rsa_$$.pub ${UNAME}@${IP}:~/.ssh/authorized_keys

echo ssh -i ~/.ssh/id_rsa_$$ ${UNAME}@${IP}
