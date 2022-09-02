#!/bin/bash

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

# Mount local host to multipass microk8s instance
VM='actionbook-v2'

echo "Mount local host on ../working to $VM:/home/ubuntu/src/working:"
echo "On OSX, need to set this up beforehand: Security & Privacy preferences > Full Disk Access > multipassd"
echo ""
echo "multipass mount ../../working $VM:/home/ubuntu/src/working"
multipass mount ../../working $VM:/home/ubuntu/src/working
echo $HR

