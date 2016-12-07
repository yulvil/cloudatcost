#!/bin/bash

set -x

NEWUSER=$1

deluser --remove-home user

adduser --disabled-password --gecos "" $NEWUSER

# Password will be disabled in the next step
echo "$NEWUSER:qwer1234" | chpasswd

# Grant sudo access to the new user
adduser $NEWUSER sudo
echo "%sudo ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
sudo -k
