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

#calculate the md5 value of the file
md5value=` md5sum $filename | awk '{ print $1 }'`

curl -v  -u "$username:$password" -H "Accept:application/json" \
		-H "Content-Type:application/json" \
		-X PUT --data "[{\"type\":\"URL\",\"parsed_data\":\"https://ndownloader.figshare.com/files/2292172\"}, {\"type\":\"TYPE\",\"parsed_data\":\"Data Carpentry pandas example file\"}, {\"type\":\"MD5\",\"parsed_data\":\"$md5value\"}]" \
		$server_url/$PID_SUFFIX
