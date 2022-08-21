#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

echo "kubectl cluster-info"
kubectl cluster-info
echo $HR


echo "kubectl get nodes"
kubectl get nodes
echo $HR 


echo "kubectl describe node actionbook-v2"
kubectl describe node actionbook-v2
echo $HR

