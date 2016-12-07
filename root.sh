#!/bin/bash

NEWUSER=$1

deluser --remove-home user

adduser --disabled-password --gecos "" $NEWUSER
# Grant sudo access to the new user
adduser $NEWUSER sudo
echo "%sudo ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers
sudo -k
