#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

host_entry='api.example.com'

if ! [[ $(grep $host_entry /etc/hosts) ]] 
then
	echo "NOT FOUND"
else
	echo "$host_entry already exists in /etc/hosts"
fi
echo $HR



# if ! [[ $(echo "$host_entry" | grep $host_entry /etc/hosts) ]] 
# then
# 	write_to_hosts $host_entry $ingress_ip 
# else
# 	echo "$host_entry already exists in /etc/hosts"
# fi
# echo $HR