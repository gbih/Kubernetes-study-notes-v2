#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set922_namespace.yaml
echo $HR

echo 'kubectl create configmap kiada-config -n=chp09-set922 --from-literal status-message="This status message is set in the kiada-config config map"'
kubectl create configmap kiada-config -n=chp09-set922 --from-literal status-message="This status message is set in the kiada-config config map"
echo ""

echo "kubectl get configmap kiada-config -o yaml -n=chp09-set922"
kubectl get configmap kiada-config -o yaml -n=chp09-set922
echo $HR

echo "kubectl apply -f $FULLPATH/set922_configmap.yaml"
kubectl apply -f $FULLPATH/set922_configmap.yaml
echo ""

echo "kubectl get configmap kiada-config-yaml -o yaml -n=chp09-set922"
kubectl get configmap kiada-config-yaml -o yaml -n=chp09-set922
echo $HR

echo "Display only the key-value pairs"
echo "kubectl get cm kiada-config-yaml -n=chp09-set922 -o json | jq .data "
kubectl get cm kiada-config-yaml -n=chp09-set922 -o json | jq .data
echo $HR 

echo "Display the value of a given entry"
echo "kubectl get cm kiada-config-yaml -n=chp09-set922 -o json | jq '.data["status-message"]'"
kubectl get cm kiada-config-yaml -n=chp09-set922 -o json | jq '.data["status-message"]'

echo "kubectl delete ns chp09-set922"
kubectl delete ns chp09-set922

echo $HR_TOP