#!/bin/bash

apt update
apt install -y nfs-common
mkdir -p /var/nfs/keys

while [ ! -f /var/nfs/keys/id_rsa ]; do
  mount 192.168.1.1:/var/nfs/keys /var/nfs/keys
  sleep 10
done

cp /var/nfs/keys/id_rsa* /users/cb100817/.ssh/
chown cb100817: /users/cb100817/.ssh/id_rsa*
runuser -u cb100817 -- cat /users/cb100817/.ssh/id_rsa.pub >> /users/cb100817/.ssh/authorized_keys
