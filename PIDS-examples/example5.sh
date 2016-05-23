#!/bin/bash    
source config.txt

# your username
username=$USERNAME

# your password
password=$PASSWORD

# pid server url 
server_url=$PID_SERVER

#the actual file
filename=$FILENAME

md5value=` md5sum $filename | awk '{ print $1 }'`

curl -v  -u "$username:$password" -H "Accept:application/json" \
		-H "Content-Type:application/json" \
		-X GET  \
		$server_url/?MD5=$md5value

