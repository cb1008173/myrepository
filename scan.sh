#!/bin/bash

#isolate the date from invalid ssh
date=$(sudo cat /var/log/auth.log |grep "Invalid user" | cut -c 1-15)

#isolate ip addr from unauthorized ssh
        #finds invalid users, cuts down the line to omit date and time information to isolate the IP address alone. then finds IP
        #removes white space at beginning for IPS that don't start with 3 numbers
ip=$(sudo cat /var/log/auth.log |grep "Invalid user" | cut -c 39-| grep -E -o "[^^][0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"|tr -d '[:blank:]')

#isolate the country from geoiplookup
country=$(sudo geoiplookup $ip | cut -c 24-)

#echo to test that it still works with assigned variables
echo "$date"
echo "$ip"
echo "$country"


#finally, this information needs to be APPENDED to a file called unauthorized.log which should be located, something like:
# >> /var/webserver_log/unauthorized.log echo "-------this separates my code------"

 while IFS= read -r line
 do
     #echo "$line"
     ip=$(echo "$line" | cut -c 39-| grep -E -o "[^^][0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"|tr -d '[:blank:]')
     date=$(echo "$line" | cut -c 1-15)
     country=$(sudo geoiplookup "$ip" | cut -c 24-)
    if ! [ -z "$ip" ] ; then
         echo "$ip $country $date"
     fi
 done <<< "$myvar"


