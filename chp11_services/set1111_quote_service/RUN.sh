#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Create namespace first"
kubectl apply -f $FULLPATH/set1111_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1111 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1111 --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
echo "kubectl wait --for=condition=Ready=True pods/quote-001 -n=chp11-set1111 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quote-001 -n=chp11-set1111 --timeout=120s

echo $HR 

kubectl apply -f $FULLPATH/set1111_svc.yaml
echo $HR 

echo "kubectl get pods -n=chp11-set1111 --show-labels | sort"
kubectl get pods -n=chp11-set1111 --show-labels | sort
echo $HR 

echo "kubectl get svc -n=chp11-set1111 -o wide"
kubectl get svc -n=chp11-set1111 -o wide
echo $HR 

echo "kubectl get events -n=chp11-set1111"
kubectl get events -n=chp11-set1111

enter_delete

echo "kubectl delete ns chp11-set1111"
kubectl delete ns chp11-set1111

echo $HR_TOP