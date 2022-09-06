#!/bin/bash

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

#####################

# Note we cannot use underbars _ in the multipass instance name, we are limited to a dash -
VM='main'

echo "Install Python stuff"
echo "Transfer requirements file from host to vm:"
#multipass exec $VM -- bash -c "sudo chmod a+wrx /home/ubuntu/src/"
multipass transfer ./requirements.txt $VM:/home/ubuntu/src/working/requirements.txt
multipass exec $VM -- bash -c "sudo apt install python3-pip -y"
multipass exec $VM -- bash -c "pip3 install -r /home/ubuntu/src/working/requirements.txt"
echo $HR

#####################

# Shell, editor-related, misc utilities

echo "Done with install"
echo $HR2
