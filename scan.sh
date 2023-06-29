#!/bin/bash
sudo cat /var/log/auth.log |grep "Invalid user" | cut -c 40-| grep -E -o "[^^][0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"
