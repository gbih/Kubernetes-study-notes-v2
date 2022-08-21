#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

echo "Imperative style of using kubectl"

echo "kubectl create namespace chp03-set331"
kubectl create namespace chp03-set331
echo $HR

echo "kubectl create deployment kiada --image=georgebaptista/kiada:0.1 -n=chp03-set331"
kubectl create deployment kiada --image=georgebaptista/kiada:0.1 -n=chp03-set331
echo $HR

echo "sleep 3"
sleep 3
echo $HR

echo "kubectl get pods -n=chp03-set331"
kubectl get pods -n=chp03-set331
echo $HR


echo "Clean up namespace and deployment"
kubectl delete namespace chp03-set331
echo ""


echo $HR_TOP