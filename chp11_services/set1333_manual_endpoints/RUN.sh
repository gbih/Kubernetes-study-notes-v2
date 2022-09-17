#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1133_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1133 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1133 --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1133 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1133 --timeout=120s
enter

echo "kubectl apply -f $FULLPATH/set1133_svc_no_pod_selector.yaml"
kubectl apply -f $FULLPATH/set1133_svc_no_pod_selector.yaml
echo $HR 

echo "Create a service with no pod selector:"
echo "kubectl get svc -n chp11-set1133 -o wide"
kubectl get svc -n chp11-set1133 -o wide
echo $HR 

echo "Create an Endpoints object manually:"
echo "kubectl apply -f $FULLPATH/set1133_endpoints.yaml"
kubectl apply -f $FULLPATH/set1133_endpoints.yaml
echo $HR 

echo "kubectl get endpoints -n chp11-set1133"
kubectl get endpoints -n chp11-set1133
echo $HR 

enter_delete

echo "kubectl delete ns chp11-set1133"
kubectl delete ns chp11-set1133

echo $HR_TOP