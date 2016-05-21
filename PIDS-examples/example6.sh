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
		-X PUT --data "[{\"type\":\"URL\",\"parsed_data\":\"<PATH>/surveys.csv\"}]" \
		$server_url/$PID_SUFFIX
