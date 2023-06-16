#!/bin/bash

#generate passswordless ssh
runuser -u cb100817 -- ssh-keygen -q -t rsa -f /users/cb100817/.ssh/id_rsa -N ''
runuser -u cb100817 -- cat /users/cb100817/.ssh/id_rsa.pub >> /users/cb100817/.ssh/authorized_keys

#setup NFS for key sharing
apt update
apt install -y nfs-kernel-server
mkdir /var/nfs/keys -p
cp /users/cb100817/.ssh/id_rsa* /var/nfs/keys
chown nobody:nogroup /var/nfs/keys
echo "/var/nfs/keys 192.168.1.2(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
systemctl restart nfs-kernel-server

#setup ansible
apt-add-repository -y ppa:ansible/anisble
apt update
apt install -y ansible
cp /local/repository/hosts/ /etc/ansible/

#setup lamp
git clone https://github.com/do-community/ansible-playbooks.git
cd ansible-playbooks/lamp_ubuntu1804/
cp /local/repository/default.yml vars/
HOST=$(hostname-f)
sed -i "s/HOSTNAME/$HOST/g" vars/default.yml
ansible-playbook playbook.yml -l server1 -u cb100817

