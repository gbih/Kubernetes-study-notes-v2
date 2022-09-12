#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
echo "The label prefixes kubernetes.io/ and k8s.io/ are reserved for Kubernetes components."
echo ""
echo "kubectl get nodes --show-labels"
kubectl get nodes --show-labels
echo $HR 

echo "kubectl get node -L kubernetes.io/arch"
kubectl get node -L kubernetes.io/arch

echo $HR_TOP