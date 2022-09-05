#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "List storage classes"
echo ""
echo "kubectl get sc"
kubectl get sc
enter


echo "kubectl get sc/microk8s-hostpath -o yaml"
kubectl get sc/microk8s-hostpath -o yaml
enter

echo "kubectl get sc/openebs-hostpath -o yaml"
kubectl get sc/openebs-hostpath -o yaml
enter

echo "kubectl get pv"
kubectl get pv

echo $HR_TOP