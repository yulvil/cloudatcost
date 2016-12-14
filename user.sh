#!/bin/bash

chmod 600 ~/.ssh/authorized_keys

sudo  timedatectl set-timezone Etc/UTC

# Disable root password
sudo passwd -l root
sudo passwd -l $USER

# Disable ssh using root
sudo sed -i 's/^PermitRootLogin/#PermitRootLogin/' /etc/ssh/sshd_config
echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config

sudo sed -i 's/^DenyUsers/#DenyUsers/' /etc/ssh/sshd_config
echo "DenyUsers root" | sudo tee -a /etc/ssh/sshd_config

sudo sed -i 's/^PasswordAuthentication/#PasswordAuthentication/' /etc/ssh/sshd_config
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config

sudo sed -i 's/^ChallengeResponseAuthentication/#ChallengeResponseAuthentication/' /etc/ssh/sshd_config
echo "ChallengeResponseAuthentication no" | sudo tee -a /etc/ssh/sshd_config

# Remove potentially duplicated host key.
sudo rm /etc/ssh/ssh_host_*
# Regenerate host keys.
sudo /usr/sbin/dpkg-reconfigure openssh-server
# printf "dsa\necdsa\ned25519\nrsa\n" | xargs -L1 -I{} ssh-keygen -t {} -N \"\" -f /etc/ssh/ssh_host_{}_key

# Firewall
sudo apt-get install -y ufw
sudo ufw --force enable
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp
sudo ufw status

# Increase hard ulimit
echo "$USER hard nofile 9999" | sudo tee -a /etc/security/limits.conf

curl -s https://getcaddy.com | bash

# Need to login again
ulimit -n 8192

# Grant access to ports < 1024
sudo setcap 'cap_net_bind_service=+ep' $(which caddy)

# Display IP addresses
hostname -I

sudo mkdir /www/
sudo chown $USER:$USER /www/

printf '
ab.cd.com {
  gzip
  log access.log
}' > Caddyfile

sudo service ssh restart
