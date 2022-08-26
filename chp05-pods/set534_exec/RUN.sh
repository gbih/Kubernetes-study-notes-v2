#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set534_namespace.yaml"
kubectl apply -f $FULLPATH/set534_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set534_pod.yaml"
kubectl apply -f $FULLPATH/set534_pod.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada -n=chp05-set534 --timeout=20s"
kubectl wait --for=condition=Ready=True pods/kiada -n=chp05-set534 --timeout=20s
echo ""

######

echo "kubectl exec kiada -n=chp05-set534 -- ps aux"
kubectl exec kiada -n=chp05-set534 -- ps aux
echo $HR


for i in {1..5}
do
  echo "kubectl exec kiada -n=chp05-set534 -- curl -s localhost:8080"
  kubectl exec kiada -n=chp05-set534 -- curl -s localhost:8080
  sleep 0.5
done


echo $HR

echo "kubectl delete ns chp05-set534"
kubectl delete ns chp05-set534