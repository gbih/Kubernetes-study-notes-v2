#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/"
kubectl apply -f $FULLPATH/set1013_namespace.yaml
kubectl apply -f $FULLPATH/set1013_secret.yaml
kubectl apply -f $FULLPATH/set1013_configmap.yaml
kubectl apply -f $FULLPATH/set1013_pod-kiada-ssl.yaml
echo $HR

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp10-set1013 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp10-set1013 --timeout=120s
echo $HR 

echo "kubectl get pods -n=chp10-set1013 -o wide"
kubectl get pods -n=chp10-set1013 -o wide
echo $HR 

echo "kubectl delete ns chp10-set1013"
kubectl delete ns chp10-set1013

echo $HR_TOP