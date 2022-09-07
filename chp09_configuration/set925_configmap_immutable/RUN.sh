#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set925_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set925_configmap.yaml"
kubectl apply -f $FULLPATH/set925_configmap.yaml
echo $HR

echo "kubectl get configmap kiada-config-yaml -n=chp09-set925"
kubectl get configmap kiada-config-yaml -n=chp09-set925
echo $HR

echo "Display only the key-value pairs"
echo "kubectl get cm kiada-config-yaml -n=chp09-set925 -o json | jq .data "
kubectl get cm kiada-config-yaml -n=chp09-set925 -o json | jq .data

enter

echo "Test whether we can mutate the config map"
echo "kubectl apply -f $FULLPATH/set925_configmap_change.yaml"
kubectl apply -f $FULLPATH/set925_configmap_change.yaml
echo $HR

echo "Display only the key-value pairs"
echo "kubectl get cm kiada-config-yaml -n=chp09-set925 -o json | jq .data "
kubectl get cm kiada-config-yaml -n=chp09-set925 -o json | jq .data
echo $HR

echo "kubectl delete ns chp09-set925"
kubectl delete ns chp09-set925

echo $HR_TOP