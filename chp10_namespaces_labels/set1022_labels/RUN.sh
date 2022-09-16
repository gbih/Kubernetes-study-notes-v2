#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1022_namespace.yaml
echo $HR

kubectl apply -f $FULLPATH/kiada --recursive
echo ""

kubectl apply -f $FULLPATH/quiz --recursive
echo ""

kubectl apply -f $FULLPATH/quote --recursive
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp10-set1022 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp10-set1022 --timeout=120s
echo $HR 

enter

echo "kubectl describe pod/kiada-001 -n=chp10-set1022 | head"
kubectl describe pod/kiada-001 -n=chp10-set1022 | head
enter


echo "kubectl get pods --show-labels -n=chp10-set1022 | sort"
kubectl get pods --show-labels -n=chp10-set1022 | sort
enter


echo "kubectl get pods -L app,rel -n=chp10-set1022 | sort"
kubectl get pods -L app,rel -n=chp10-set1022 | sort

enter

echo "Label all objects of a kind, in imperative style."
echo "kubectl label pod --all suite=kiada-suite --overwrite -n=chp10-set1022"
kubectl label pod --all suite=kiada-suite --overwrite -n=chp10-set1022 
echo $HR

echo "kubectl get pods --show-labels -n=chp10-set1022  | sort"
kubectl get pods --show-labels -n=chp10-set1022  | sort

enter


echo "Remove label from objects, in imperative style."
echo "kubectl label pod --all suite- --overwrite -n=chp10-set1022"
kubectl label pod --all suite- --overwrite -n=chp10-set1022 
echo $HR

echo "kubectl get pods --show-labels -n=chp10-set1022  | sort"
kubectl get pods --show-labels -n=chp10-set1022  | sort
echo $HR 

echo "kubectl get events -n=chp10-set1022"
kubectl get events -n=chp10-set1022

enter_delete

echo "kubectl delete ns chp10-set1022"
kubectl delete ns chp10-set1022

echo $HR_TOP