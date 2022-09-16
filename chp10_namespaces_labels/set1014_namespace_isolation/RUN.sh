#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/"
kubectl apply -f $FULLPATH/set1014_namespace.yaml
kubectl apply -f $FULLPATH/set1014_secret.yaml
kubectl apply -f $FULLPATH/set1014_configmap.yaml
kubectl apply -f $FULLPATH/set1014_pod-kiada-ssl.yaml
echo $HR

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp10-set1014 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp10-set1014 --timeout=120s
echo $HR 

echo "kubectl get all-n=chp10-set1014 -o wide"
kubectl get all -n=chp10-set1014 -o wide
echo $HR 

echo -e "NODES\t\tNAMES"
kubectl get pods -A -o jsonpath='{range .items[*]}{@.spec.nodeName}{"\t\t"}{@.metadata.name}{"\n"}{end}' 
echo $HR

echo "kubectl get events -n=chp10-set1014"
kubectl get events -n=chp10-set1014

enter_delete

echo "kubectl delete ns chp10-set1014"
kubectl delete ns chp10-set1014

echo $HR_TOP