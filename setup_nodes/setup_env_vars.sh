#!/bin/bash

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

#####################

# Note we cannot use underbars _ in the multipass instance name, we are limited to a dash -
VM='actionbook-v2'

echo $HR2

#####################
echo "Make sure to create and use environmental variables for docker account."
echo "For example, on the host CLI:"
echo ""
echo "DOCKER_USER=..."
echo "export DOCKER_USER"
echo "DOCKER_PWD=..."
echo "export DOCKER_PWD"
echo "printenv"
echo ""
echo "In your script"
echo "$DOCKER_USER"
echo "$DOCKER_PWD"

echo "Assuming we pass docker username and passwd as environmental variables"
multipass list
multipass exec $VM -- bash -c "sudo docker login --username $DOCKER_USER --password $DOCKER_PWD"
echo $HR