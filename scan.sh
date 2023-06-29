#!/bin/bash

#isolate ip addr from unauthorized ssh
#finds invalid users, cuts down the line to omit date and time information to isolate the IP address alone. then finds IP
sudo cat /var/log/auth.log |grep "Invalid user" | cut -c 40-| grep -E -o "[^^][0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"
