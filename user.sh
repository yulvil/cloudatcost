#!/bin/bash

chmod 600 ~/.ssh/authorized_keys

sudo  timedatectl set-timezone Etc/UTC

# Disable root password
sudo passwd -l root

# Disable ssh using root
sudo sed -i 's/^PermitRootLogin/#PermitRootLogin/' /etc/ssh/sshd_config
echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config

sudo sed -i 's/^DenyUsers/#DenyUsers/' /etc/ssh/sshd_config
echo "DenyUsers root" | sudo tee -a /etc/ssh/sshd_config

sudo sed -i 's/^PasswordAuthentication/#PasswordAuthentication/' /etc/ssh/sshd_config
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config

sudo sed -i 's/^ChallengeResponseAuthentication/#ChallengeResponseAuthentication/' /etc/ssh/sshd_config
echo "ChallengeResponseAuthentication no" | sudo tee -a /etc/ssh/sshd_config

sudo service ssh restart

# Firewall
sudo ufw enable
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp
sudo ufw status

# Increase hard ulimit
echo "$USER hard nofile 9999" | sudo tee -a /etc/security/limits.conf

curl -s https://getcaddy.com | bash

# Need to login again
ulimit -n 8192

printf '
ab.cd.com {
  gzip
  log access.log
}' > Caddyfile
