#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set923_namespace.yaml
kubectl apply -f $FULLPATH/set923_configmap.yaml
kubectl apply -f $FULLPATH/set923_pod.yaml
echo $HR



echo "kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set923 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set923 --timeout=120s
echo $HR

echo "kubectl get configmap kiada-config -o yaml -n=chp09-set923"
kubectl get configmap kiada-config -o yaml -n=chp09-set923
echo $HR

echo "Display only the key-value pairs"
echo "kubectl get cm kiada-config -n=chp09-set923 -o json | jq .data "
kubectl get cm kiada-config -n=chp09-set923 -o json | jq .data
echo $HR 

echo "Display the value of a given entry"
echo "kubectl get cm kiada-config -n=chp09-set923 -o json | jq '.data["status-message"]'"
kubectl get cm kiada-config -n=chp09-set923 -o json | jq '.data["status-message"]'
echo $HR 

echo "Check env-vars of the pod:"
echo "kubectl exec kiada -n=chp09-set923 -- env"
kubectl exec kiada -n=chp09-set923 -- env
echo $HR

echo "kubectl delete ns chp09-set923"
kubectl delete ns chp09-set923

echo $HR_TOP