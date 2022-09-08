#!/bin/bash

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

#####

# We cannot use underbars _ in the multipass instance name, we are limited to a dash -

# Define worker node
node_worker='worker2'

# Define main node
node_main='main'

echo "node_worker: $node_worker"
echo "main node: $node_main"

echo $HR2

#####

echo "Make sure we start with a clean install"
multipass delete $node_worker
multipass purge
multipass list
echo $HR

echo "Provision $node_worker with Multipass"
echo ""

echo "multipass launch --name $node_worker --disk 10G --cpus 1 --mem 5G"
multipass launch --name $node_worker --disk 10G --cpus 1 --mem 5G
echo $HR

echo "Check info"
multipass info $node_worker
echo $HR

#####

echo "Install microk8s"
multipass exec $node_worker -- bash -c "sudo snap install microk8s --classic"
echo $HR

echo "Add the user ubuntu to the 'microk8s' group:"
multipass exec $node_worker -- bash -c "sudo usermod -a -G microk8s ubuntu"
multipass exec $node_worker -- bash -c "sudo chown -f -R ubuntu ~/.kube"
echo $HR

echo "Copy microk8s config"
multipass exec $node_worker -- bash -c "microk8s config > microk8s.yaml"
echo $HR

echo "Create alias"
multipass exec $node_worker -- bash -c "sudo snap alias microk8s.kubectl kubectl"
echo $HR

echo "Check status while Kubernetes starts"
multipass exec $node_worker -- bash -c "sudo microk8s status --wait-ready"
echo $HR
