#!/bin/bash

# https://microk8s.io/docs/clustering

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

#####

# We cannot use underbars _ in the multipass instance name, we are limited to a dash -

# Define main node
node_worker='worker'
echo "node_worker: $node_worker"

echo "Log into the worker pod, then run 'microk8s leave'"

echo "To complete the node removal, call microk8s remove-node from the remaining nodes to indicate that the departing (unreachable now) node should be removed permanently:"
echo "For example, log into the main node, then 'microk8s remove-node worker1'"

echo $HR2