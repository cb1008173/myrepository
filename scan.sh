#!/bin/bash

#isolate the date from invalid ssh
sudo cat /var/log/auth.log |grep "Invalid user" | cut -c 1-15

#isolate ip addr from unauthorized ssh
        #finds invalid users, cuts down the line to omit date and time information to isolate the IP address alone. then finds IP
        #removes white space at beginning for IPS that don't start with 3 numbers
sudo cat /var/log/auth.log |grep "Invalid user" | cut -c 39-| grep -E -o "[^^][0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"|tr -d '[:blank:]'
