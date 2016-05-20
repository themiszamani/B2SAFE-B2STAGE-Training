#!/bin/bash    
source config.txt

# your username
username=$USERNAME

# your password
password=$PASSWORD

# pid server url 
server_url=$PID_SERVER

SUFFIX=`uuidgen`

curl -u "$username:$password" -H "Accept:application/json" \
		-H "Content-Type:application/json" \
		-X PUT --data "[{\"type\":\"URL\",\"parsed_data\":\"https://ndownloader.figshare.com/files/2292172\"}]" \
		$server_url/$SUFFIX

curl -v  -u "$username:$password" -H "Accept:application/json" \
                -H "Content-Type:application/json" \
                -X PUT --data "[{\"type\":\"URL\",\"parsed_data\":\"/<PATH>/surveys.csv\"},{\"type\":\"SAME_AS\",\"parsed_data\":\"841/$SUFFIX\"}]" \
                $server_url/$PID_SUFFIX

