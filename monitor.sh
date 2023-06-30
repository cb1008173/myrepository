#!/bin/bash
changes=$(diff /var/webserver_monitor/unauthorized.log /var/webserver_monitor/unauthorized2.log)

if [ -z "$changes" ] ; then
    echo "no changes"
else
    echo "$changes"
fi
