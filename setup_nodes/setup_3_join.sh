#!/bin/bash

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

#####

# We cannot use underbars _ in the multipass instance name, we are limited to a dash -

# Define main node
node_main='main'

# Define worker node
node_worker='worker1'

echo "node_main: $node_main"
echo "node_worker: $node_worker"

echo $HR2

#####

echo "Check node IP addresses:"
multipass exec $node_main -- bash -c "kubectl get nodes -o wide"

echo $HR

# Get internal ip of main node
node_main_ip=$(multipass exec $node_main -- bash -c "kubectl get node $node_main -o jsonpath='{.status.addresses[0].address}'")
echo "node_main_ip: $node_main_ip"

# Get internal ip of worker1 node
node_worker_ip=$(multipass exec $node_worker -- bash -c "kubectl get node $node_worker -o jsonpath='{.status.addresses[0].address}'")
echo "node_worker_ip: $node_worker_ip"

echo $HR

# Add to /etc/hosts of main-node
multipass exec $node_main -- bash -c "sudo chmod 666 /etc/hosts"
multipass exec $node_main -- bash -c "sudo echo '$node_main_ip $node_main' >> /etc/hosts"
multipass exec $node_main -- bash -c "sudo echo '$node_worker_ip $node_worker' >> /etc/hosts"
echo ""
echo "Check contents of /etc/hosts on $node_main:"
echo ""
multipass exec $node_main -- bash -c "cat /etc/hosts"

echo $HR

# Add to /etc/hosts of worker-node
multipass exec $node_worker -- bash -c "sudo chmod 666 /etc/hosts"
multipass exec $node_worker -- bash -c "sudo echo '$node_main_ip $node_main' >> /etc/hosts"
multipass exec $node_worker -- bash -c "sudo echo '$node_worker_ip $node_worker' >> /etc/hosts"
echo ""
echo "Check contents of /etc/hosts on $node_worker:"
echo ""
multipass exec $node_worker -- bash -c "cat /etc/hosts"

echo $HR 

echo "This will add a node on the main node:"
echo "Get token from main node:"
echo "join_worker=$""(multipass exec $node_main -- bash -c 'microk8s add-node' | grep 'microk8s join' -m1"")"
join_worker=$(multipass exec $node_main -- bash -c "microk8s add-node" | grep "microk8s join" -m1)
echo $join_worker
echo ""
echo "Access $node_worker and join from there:"
echo 'multipass exec $node_worker -- bash -c "$join_worker"'
multipass exec $node_worker -- bash -c "$join_worker"

echo $HR 

echo "Done creating cluster between $node_main and $node_worker"

echo $HR2
