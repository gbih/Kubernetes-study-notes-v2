#!/bin/bash

# Reference: https://microk8s.io/docs/clustering

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
node_worker2='worker2'

echo "node_main: $node_main"
echo "node_worker1: $node_worker1"
echo "node_worker2: $node_worker2"

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

# Get internal ip of worker2 node
node_worker2_ip=$(multipass info $node_worker2 | grep IPv4 | cut -d ':' -f 2 | xargs)
echo "node_worker2_ip: $node_worker2_ip"
echo $HR


# Add to /etc/hosts of main-node
multipass exec $node_main -- bash -c "sudo chmod 666 /etc/hosts"
multipass exec $node_main -- bash -c "sudo echo '$node_main_ip $node_main' >> /etc/hosts"
multipass exec $node_main -- bash -c "sudo echo '$node_worker1_ip $node_worker1' >> /etc/hosts"
multipass exec $node_main -- bash -c "sudo echo '$node_worker2_ip $node_worker2' >> /etc/hosts"
echo ""
echo "Check contents of /etc/hosts on $node_main:"
echo ""
multipass exec $node_main -- bash -c "cat /etc/hosts"
echo $HR


# Add to /etc/hosts of worker1-node
multipass exec $node_worker1 -- bash -c "sudo chmod 666 /etc/hosts"
multipass exec $node_worker1 -- bash -c "sudo echo '$node_main_ip $node_main' >> /etc/hosts"
multipass exec $node_worker1 -- bash -c "sudo echo '$node_worker1_ip $node_worker1' >> /etc/hosts"
multipass exec $node_worker1 -- bash -c "sudo echo '$node_worker2_ip $node_worker2' >> /etc/hosts"
echo ""
echo "Check contents of /etc/hosts on $node_worker1:"
echo ""
multipass exec $node_worker1 -- bash -c "cat /etc/hosts"
echo $HR 


# Add to /etc/hosts of worker2-node
multipass exec $node_worker2 -- bash -c "sudo chmod 666 /etc/hosts"
multipass exec $node_worker2 -- bash -c "sudo echo '$node_main_ip $node_main' >> /etc/hosts"
multipass exec $node_worker2 -- bash -c "sudo echo '$node_worker1_ip $node_worker1' >> /etc/hosts"
multipass exec $node_worker2 -- bash -c "sudo echo '$node_worker2_ip $node_worker2' >> /etc/hosts"
echo ""
echo "Check contents of /etc/hosts on $node_worker2:"
echo ""
multipass exec $node_worker2 -- bash -c "cat /etc/hosts"
echo $HR 


echo "This will add worker1 to the main node:"
echo "Get token from main node:"
echo "join_worker1=$""(multipass exec $node_main -- bash -c 'microk8s add-node' | grep 'microk8s join' -m1"")"
join_worker1=$(multipass exec $node_main -- bash -c "microk8s add-node" | grep "microk8s join" -m1)
echo $join_worker1
echo ""
echo "Access $node_worker1 and join from there:"
echo 'multipass exec $node_worker1 -- bash -c "$join_worker1 --worker"'
multipass exec $node_worker1 -- bash -c "$join_worker1 --worker"
echo $HR 


echo "This will add worker2 to the main node:"
echo "Get token from main node:"
echo "join_worker2=$""(multipass exec $node_main -- bash -c 'microk8s add-node' | grep 'microk8s join' -m1"")"
join_worker2=$(multipass exec $node_main -- bash -c "microk8s add-node" | grep "microk8s join" -m1)
echo $join_worker2
echo ""
echo "Access $node_worker2 and join from there:"
echo 'multipass exec $node_worker2 -- bash -c "$join_worker2 --worker"'
multipass exec $node_worker2 -- bash -c "$join_worker2 --worker"
echo $HR 


echo "Done creating cluster between $node_main and $node_worker1 and $node_worker2"

echo $HR2