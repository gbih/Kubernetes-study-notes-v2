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

# Create multipass VM

echo "Provision the virtual machine $VM with Multipass"
echo ""

echo "Make sure we start with a clean install"
multipass purge
multipass list
echo $HR


echo "multipass launch --name $VM --disk 50G --cpus 2 --mem 6G"
multipass launch --name $VM --disk 50G --cpus 2 --mem 6G
echo $HR

echo "Check info"
multipass info $VM
echo $HR

#####################

# Install Microk8s Kubernetes distribution

echo "Install microk8s"
multipass exec $VM -- bash -c "sudo snap install microk8s --classic --channel=1.19/stable"
echo $HR

echo "Disable ha-cluster, re-enable etfd"
multipass exec $VM -- bash -c "sudo microk8s.disable ha-cluster"
multipass exec $VM -- bash -c "sudo snap install etcd"
echo $HR

echo "Add the user ubuntu to the 'microk8s' group:"
multipass exec $VM -- bash -c "sudo usermod -a -G microk8s ubuntu"
multipass exec $VM -- bash -c "sudo chown -f -R ubuntu ~/.kube"
echo $HR

echo "Check the status while Kubernetes starts"
multipass exec $VM -- bash -c "microk8s config > microk8s.yaml"
multipass exec $VM -- bash -c "cat microk8s.yaml"
echo $HR

echo "Create alias"
multipass exec $VM -- bash -c "sudo snap alias microk8s.kubectl kubectl"
multipass exec $VM -- bash -c "sudo microk8s status --wait-ready"
echo $HR

echo "Turn on the services you want"
multipass exec $VM -- bash -c "sudo microk8s enable dns storage ingress metallb:10.64.150.43-10.64.150.49"
multipass exec $VM -- bash -c "sudo microk8s status --wait-ready"
echo $HR

echo "Confirm running services"
multipass exec $VM -- bash -c "sudo microk8s.inspect"
echo $HR

#####################

# Install Docker and Python

echo "Docker installation"
multipass exec $VM -- bash -c "sudo apt-get update"
multipass exec $VM -- bash -c "sudo apt install docker.io -y"
multipass exec $VM -- bash -c "sudo docker version"
echo "Assuming we pass docker username and passwd as environmental variables"
multipass exec $VM -- bash -c "sudo docker login --username $DOCKER_USER --password $DOCKER_PWD"
echo $HR

echo "Docker test"
multipass exec $VM -- bash -c "sudo usermod -aG docker ubuntu"
multipass exec $VM -- bash -c "docker run busybox echo 'Hello world'"
multipass exec $VM -- bash -c "sudo microk8s status --wait-ready"
echo $HR

echo "Install Python stuff"
echo "Transfer requirements file from host to vm:"
multipass transfer ./requirements.txt $VM:/home/ubuntu/src/
multipass exec $VM -- bash -c "sudo apt install python3-pip -y"
multipass exec $VM -- bash -c "pip3 install -r src/requirements.txt"
echo $HR

#####################

# Shell and editor-related

echo "Shorten bash shell:"
multipass exec $VM -- bash -c "echo 'export PROMPT_DIRTRIM=1' >> ~/.bashrc"
multipass exec $VM -- bash -c "source ~/.bashrc source"
echo $HR

echo "Install resize"
multipass exec $VM -- bash -c "sudo apt-get update"
multipass exec $VM -- bash -c "sudo apt-get install xterm -y"
multipass exec $VM -- bash -c "sudo apt-get install rename"
echo $HR

#####################

# Mount local host to multipass microk8s instance

echo "Mount local host on ./working to $VM:/home/ubuntu/src/working:"
echo "On OSX, need to set this up beforehand: Security & Privacy preferences > Full Disk Access > multipassd"
echo ""
echo "multipass mount ./working $VM:/home/ubuntu/src/working"
multipass mount ./working $VM:/home/ubuntu/src/working
echo $HR

#####################

echo "Done with install"
echo $HR2
