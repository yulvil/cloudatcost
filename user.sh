#!/bin/bash

mkdir ~/.ssh
chmod 700 ~/.ssh
cat ~/id_rsa*.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
rm ~/id_rsa*.pub
