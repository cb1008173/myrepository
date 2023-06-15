#!/bin/bash

#generate passswordless ssh
runuser -u cb100817 -- ssh-keygen -q -t rsa -f /users/cb100817/.ssh/id_rsa -N ''
runuser -u cb100817 -- cat /users/cb100817/.ssh/id_rsa.pub >> /users/cb100817/.ssh/authorized_keys
