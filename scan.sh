#!/bin/bash

#isolate the dates from invalid ssh
myvar=$(sudo cat /var/log/auth.log |grep "Invalid user")
#echo "$myvar"

date=$(sudo cat /var/log/auth.log |grep "Invalid user" | cut -c 1-15)
#isolate ip addresses from unauthorized ssh
        #finds invalid users, cuts down the line to omit date and time information to isolate the IP address alone. then finds IP
        #removes white space at beginning for IPS that don't start with 3 numbers
ip=$(sudo cat /var/log/auth.log |grep "Invalid user" | cut -c 39-| grep -E -o "[^^][0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"|tr -d '[:>

#isolate the countries from geoiplookup
country=$(sudo geoiplookup $ip | cut -c 24-)

#echo "$ip $country $date" >> /var/webserver_log/unauthorized.log

# compare IP addresses in the auth.log file, to the IP addresses in the unauthorized.log file.
# if there is an IP address in auth.log, that is NOT in unauthorized.log, then append.
"$myvar" | while read -r line
do
     ip=$(echo "$line" | cut -c 39-| grep -E -o "[^^][0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"|tr -d '[:blank:]')    
     date=$(echo "$line" | cut -c 1-15)
     echo "$ip $date"
     if ! grep "$date" /var/webserver_log/unauthorized.log ; then
             echo "$ip $country $date" # >> /var/webserver_log/unauthorized.log
     fi
done

 echo "-------this separates my code------"

 while IFS= read -r line
 do
     #echo "$line"
     ip=$(echo "$line" | cut -c 39-| grep -E -o "[^^][0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"|tr -d '[:blank:]')
     date=$(echo "$line" | cut -c 1-15)
     country=$(sudo geoiplookup "$ip" | cut -c 24-)
     if ! [ -z "$ip" ] ; then
         if !  grep "$date" /var/webserver_log/unauthorized.log ; then   
             echo "$ip $country $date" >> /var/webserver_log/unauthorized.log
         fi
     fi
 done <<< "$myvar"


