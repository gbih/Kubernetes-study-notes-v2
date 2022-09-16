#!/bin/bash

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

#####

# We cannot use underbars _ in the multipass instance name, we are limited to a dash -

# Define main node
node_main='main'

# Define worker node2
node_worker1='worker1'


echo "node_main: $node_main"
echo "node_worker1: $node_worker1"


hosts_pathway='/etc/cloud/templates/hosts.debian.tmpl'
#hosts_pathway='/etc/hosts'

echo $HR2

#####

echo "Check node IP addresses:"
multipass exec $node_main -- bash -c "kubectl get nodes -o wide"

echo $HR


# If we use the --worker option, can no longer use the 'multipass exec' command
# Get internal ip of main node
node_main_ip=$(multipass info $node_main | grep IPv4 | cut -d ':' -f 2 | xargs)
echo "node_main_ip: $node_main_ip"

# Get internal ip of worker1 node
node_worker1_ip=$(multipass info $node_worker1 | grep IPv4 | cut -d ':' -f 2 | xargs)
echo "node_worker1_ip: $node_worker1_ip"




# Add to /etc/hosts of main-node

multipass exec $node_main -- bash -c "sudo chmod 666 $hosts_pathway"
multipass exec $node_main -- bash -c "sudo echo '$node_main_ip $node_main' >> $hosts_pathway"
multipass exec $node_main -- bash -c "sudo echo '$node_worker1_ip $node_worker1' >> $hosts_pathway"
echo ""
echo "Check contents of $hosts_pathway on $node_main:"
echo ""
multipass exec $node_main -- bash -c "cat $hosts_pathway"
echo $HR


# Add to /etc/hosts of worker1-node
multipass exec $node_worker1 -- bash -c "sudo chmod 666 $hosts_pathway"
multipass exec $node_worker1 -- bash -c "sudo echo '$node_main_ip $node_main' >> $hosts_pathway"
multipass exec $node_worker1 -- bash -c "sudo echo '$node_worker1_ip $node_worker1' >> $hosts_pathway"
echo ""
echo "Check contents of $hosts_pathway on $node_worker1:"
echo ""
multipass exec $node_worker1 -- bash -c "cat $hosts_pathway"
echo $HR 


echo "Done writing to $hosts_pathway"

echo $HR2