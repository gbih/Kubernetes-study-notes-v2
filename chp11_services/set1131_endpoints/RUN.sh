#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1131_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1131 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1131 --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1131 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1131 --timeout=120s

echo $HR 

kubectl apply -f $FULLPATH/set1131_svc_loadbalancer_kiada.yaml
kubectl apply -f $FULLPATH/set1131_svc_quote.yaml
kubectl apply -f $FULLPATH/set1131_svc_quiz.yaml

echo $HR 

echo "kubectl describe svc kiada -n chp11-set1131"
echo ""
kubectl describe svc kiada -n chp11-set1131

enter

echo "kubectl get endpoints kiada -n chp11-set1131"
echo ""
kubectl get endpoints kiada -n chp11-set1131

enter

echo "kubectl describe endpoints kiada -n chp11-set1131"
echo ""
kubectl describe endpoints kiada -n chp11-set1131

enter_delete

echo "kubectl delete ns chp11-set1131"
kubectl delete ns chp11-set1131

echo $HR_TOP