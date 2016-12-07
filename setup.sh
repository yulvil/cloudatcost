#!/bin/bash

if [[ -z $CACIP || -z $CACUSER ]]; then
  echo "Usage..."
  exit 1
fi

ssh root@$CACIP "curl -s https://raw.githubusercontent.com/yulvil/cloudatcost/master/root.sh | bash -s \"$CACUSER\""

CACPWD=$(cat /proc/sys/kernel/random/uuid)
echo $CACPWD
curl -s https://raw.githubusercontent.com/yulvil/cloudatcost/master/user_local.sh | bash -s $CACIP $CACUSER $CACPWD

ssh $CACUSER@$CACIP 'curl -s https://raw.githubusercontent.com/yulvil/cloudatcost/master/user.sh | bash -s'
