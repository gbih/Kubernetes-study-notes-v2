#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "List storage classes"
echo ""
echo "kubectl get sc"
kubectl get sc
echo $HR

echo "kubectl get sc -o yaml"
kubectl get sc -o yaml

echo $HR_TOP