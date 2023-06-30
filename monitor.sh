#!/bin/bash
changes=$(diff /var/webserver_monitor/unauthorized.log /var/webserver_monitor/unauthorized2.log)

if [ -z "$changes" ] ; then
    mail -s "changes to unauthorized.log" cb1008175@wcupa.edu <<< "no unauthorized access"
    sudo cp /var/webserver_monitor/unauthorized.log /var/webserver_monitor/unauthorized2.log
else
    mail -s "changes to unauthorized.log" cb1008175@wcupa.edu <<< "$changes"
    sudo cp /var/webserver_monitor/unauthorized.log /var/webserver_monitor/unauthorized2.log
fi
