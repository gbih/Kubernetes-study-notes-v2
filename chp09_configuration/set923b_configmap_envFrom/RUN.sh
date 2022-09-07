#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set923b_namespace.yaml
kubectl apply -f $FULLPATH/set923b_configmap.yaml
kubectl apply -f $FULLPATH/set923b_pod.yaml
echo $HR

echo "kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set923b --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set923b --timeout=120s
echo $HR

echo "Display only the key-value pairs"
echo "kubectl get cm kiada-config -n=chp09-set923b -o json | jq .data "
kubectl get cm kiada-config -n=chp09-set923b -o json | jq .data
echo $HR 

echo "Display the value of a given entry"
echo "kubectl get cm kiada-config -n=chp09-set923b -o json | jq '.data["status-message"]'"
kubectl get cm kiada-config -n=chp09-set923b -o json | jq '.data["status-message"]'
echo $HR 

echo "Check env-vars of the pod:"
echo "kubectl exec kiada -n=chp09-set923b -- env"
kubectl exec kiada -n=chp09-set923b -- env
echo $HR

echo "kubectl delete ns chp09-set923b"
kubectl delete ns chp09-set923b

echo $HR_TOP