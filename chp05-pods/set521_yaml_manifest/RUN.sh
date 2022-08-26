#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set521_namespace.yaml"
kubectl apply -f $FULLPATH/set521_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set521_pod.yaml"
kubectl apply -f $FULLPATH/set521_pod.yaml

echo $HR 

######

echo "kubectl wait --for=condition=Ready=True pods/kiada -n=chp05-set521 --timeout=20s"
kubectl wait --for=condition=Ready=True pods/kiada -n=chp05-set521 --timeout=20s
echo ""

enter

echo "kubectl get pods -n=chp05-set521 -o json"
kubectl get pods -n=chp05-set521 -o json

sleep 1

enter




echo "kubectl get pods -l '!env' -n=chp05-set521 --show-labels"
kubectl get pods -l '!env' -n=chp05-set521 --show-labels

echo $HR

echo "IP=\$(kubectl get pod -n=chp05-set521 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp05-set521 -o jsonpath='{.items[0].status.podIP}')

# echo ""

for i in {1..5}
do
  echo "curl $IP:8080"
  curl $IP:8080
  echo "" 
  sleep 0.5
done

enter


echo "kubectl run --image=curlimages/curl -it --restart=Never --rm kiada curl $IP:8080"
kubectl run --image=curlimages/curl -it --restart=Never --rm kiada curl $IP:8080
enter


echo "kubectl get pod kiada -o yaml -n=chp05-set521"
kubectl get pod kiada -o yaml -n=chp05-set521

enter

echo "kubectl logs kiada -c kiada -n=chp05-set521"
kubectl logs kiada -c kiada -n=chp05-set521
echo $HR

echo "kubectl delete ns chp05-set521"
kubectl delete ns chp05-set521