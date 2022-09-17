#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1132_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1132 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1132 --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1132 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1132 --timeout=120s

enter

kubectl apply -f $FULLPATH/set1132_svc_loadbalancer_kiada.yaml
kubectl apply -f $FULLPATH/set1132_svc_quote.yaml
kubectl apply -f $FULLPATH/set1132_svc_quiz.yaml

echo $HR 

echo "kubectl get endpointslices -n chp11-set1132"
kubectl get endpointslices -n chp11-set1132
echo $HR 

echo "kubectl get endpointslices -l kubernetes.io/service-name=kiada -n chp11-set1132"
kubectl get endpointslices -l kubernetes.io/service-name=kiada -n chp11-set1132

enter

echo "kubectl describe endpointslices kiada -n chp11-set1132"
kubectl describe endpointslices kiada -n chp11-set1132
echo $HR 

enter_delete

echo "kubectl delete ns chp11-set1132"
kubectl delete ns chp11-set1132

echo $HR_TOP