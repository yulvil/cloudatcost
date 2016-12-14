#!/bin/bash

if [[ -z $CACIP || -z $CACUSER || -z $CACSUBDOMAIN ]]; then
  echo "Usage..."
  exit 1
fi

ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no root@$CACIP '
  wget -O /etc/apt/sources.list https://raw.githubusercontent.com/yulvil/cloudatcost/master/debian/sources.list
  apt-get update
  apt-get upgrade -y
  apt-get dist-upgrade -y
  curl -s https://raw.githubusercontent.com/yulvil/cloudatcost/master/root.sh | bash -s \"$CACUSER\"'
if [[ $? -ne 0 ]]; then
  exit $?
fi

CACPWD=$(cat /proc/sys/kernel/random/uuid | tr -d '-')
echo $CACPWD
curl -s https://raw.githubusercontent.com/yulvil/cloudatcost/master/user_local.sh | bash -s $CACIP $CACSUBDOMAIN $CACUSER $CACPWD

ssh $CACUSER@$CACIP 'curl -s https://raw.githubusercontent.com/yulvil/cloudatcost/master/user.sh | bash -s'
