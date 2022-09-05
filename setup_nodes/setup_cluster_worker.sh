#!/bin/bash

clear

resize > /dev/null 2>&1 # redirect output and error

HR=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
HR2=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =)

#####################

# References:
# https://pancho.dev/posts/multipass-microk8s-cluster/
# https://dev.to/musabhusaini/remote-development-with-multi-node-microk8s-cluster-and-scaffold-4o1d

# Note we cannot use underbars _ in the multipass instance name, we are limited to a dash -

# Define this worker node
node='worker1'

# Define main node
main_node='cluster-main'
echo "node: $node"
echo "main node: $main_node"

echo $HR2

#####################

# Create multipass VM

echo "Provision the virtual machine $node with Multipass"
echo ""

# echo "Make sure we start with a clean install"
# multipass delete $node
# multipass purge
# multipass list
# echo $HR

echo "multipass launch --name $node --disk 5G --cpus 1 --mem 2G"
multipass launch --name $node --disk 5G --cpus 1 --mem 2G
echo $HR

echo "Check info"
multipass info $node
echo $HR

#####################

# Install Microk8s Kubernetes distribution

echo "Install microk8s"
multipass exec $node -- bash -c "sudo snap install microk8s --classic"
echo $HR

echo "Add the user ubuntu to the 'microk8s' group:"
multipass exec $node -- bash -c "sudo usermod -a -G microk8s ubuntu"
multipass exec $node -- bash -c "sudo chown -f -R ubuntu ~/.kube"
echo $HR

echo "Check the status while Kubernetes starts"
multipass exec $node -- bash -c "microk8s config > microk8s.yaml"
#multipass exec $node -- bash -c "cat microk8s.yaml"
echo $HR

echo "Create alias"
multipass exec $node -- bash -c "sudo snap alias microk8s.kubectl kubectl"
multipass exec $node -- bash -c "sudo microk8s status --wait-ready"
echo $HR

echo "This will add a node on the main node:"
echo "join_worker=$""(multipass exec $main_node -- bash -c 'microk8s add-node' | grep 'microk8s join' -m1"")"
join_worker=$(multipass exec $main_node -- bash -c "microk8s add-node" | grep "microk8s join" -m1)
echo $join_worker
multipass exec $node -- bash -c "$join_worker"

echo "Done with install"
echo $HR2


# Assuming this:
# actionbook-v2           Running           192.168.64.5
# cluster-main            Running           192.168.64.13
# worker1                 Running           192.168.64.11
# 
# Get this error message:
# Connection failed. The hostname (worker1) of the joining node does not resolve to 
# the IP "192.168.64.11". Refusing join (400).
# 
# May need to do this:
# You need to make sure that your control plane node can also resolve worker1 to 192.168.64.11
# On both cluster-main and worker1, edit the /etc/hosts file to add:
# 192.168.64.11 worker1

# Get this message:
# Currently this worker node is configured with the following kubernetes API server endpoints:
# - 192.168.64.13 and port 16443, this is the cluster node contacted during the join operation.
# Maybe try this:
# curl https://192.168.64.13:16443 -s
# 
# On the master:
# kubectl get nodes
#
# NAME           STATUS   ROLES    AGE     VERSION
# worker1        Ready    <none>   3m20s   v1.24.3-2+63243a96d1c393
# cluster-main   Ready    <none>   26m     v1.24.3-2+63243a96d1c393
