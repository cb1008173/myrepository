#!/bin/bash
sudo egrep "Invalid user" /var/log/auth.log | cut -c 69-77
