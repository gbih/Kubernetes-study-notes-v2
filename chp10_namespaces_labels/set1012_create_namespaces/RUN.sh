#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Create namespace imperatively via CLI."
echo "kubectl create namespace kiada-tes1"
kubectl create namespace kiada-test1
echo $HR 

echo "Create namespace declaratively via YAML manifest file."
echo "kubectl apply -f $FULLPATH/set1012_namespace.yaml"
kubectl apply -f $FULLPATH/set1012_namespace.yaml
echo $HR 

echo "kubectl get ns"
kubectl get ns
echo $HR 



echo "kubectl delete ns kiada-test1"
kubectl delete ns kiada-test1
echo ""

echo "kubectl delete ns kiada-test2"
kubectl delete ns kiada-test2

echo $HR_TOP