#!/bin/bash    
source config.txt
# your username
username=$USERNAME
# your password
password=$PASSWORD
# pid server url 
server_url=$PID_SERVER

curl -v  -u "$username:$password" -H "Accept:application/json" \
		-H "Content-Type:application/json" \
		-X PUT --data "[{\"type\":\"URL\",\"parsed_data\":\"https://ndownloader.figshare.com/files/2292172\"},{\"type\":\"TYPE\",\"parsed_data\":\"Data Carpentry pandas example file\"}]" \
		$server_url/$PID_SUFFIX
