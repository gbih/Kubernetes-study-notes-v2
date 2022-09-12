#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl get ns"
kubectl get ns
echo $HR 

echo "List pods in the kube-system namespace."
echo "kubectl get pods -n=kube-system -o wide"
kubectl get pods -n=kube-system -o wide
echo $HR 

echo "Listing objects across all namespaces (eg ConfigMap)"
echo "kubectl get cm -A"
kubectl get cm -A

echo $HR_TOP