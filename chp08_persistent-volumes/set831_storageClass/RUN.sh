#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "List storage classes"
echo ""
echo "kubectl get sc -n=chp08-set831"
kubectl get sc -n=chp08-set831
echo $HR

echo "kubectl get sc -o yaml"
kubectl get sc -o yaml

echo $HR_TOP