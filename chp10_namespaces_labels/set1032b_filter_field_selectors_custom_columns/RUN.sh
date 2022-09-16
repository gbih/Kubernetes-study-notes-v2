#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Create namespace first"
kubectl apply -f $FULLPATH/set1032b_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp10-set1032b"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp10-set1032b

echo $HR

kubectl apply -f $FULLPATH/kiada --recursive
echo ""

kubectl apply -f $FULLPATH/quiz --recursive
echo ""

kubectl apply -f $FULLPATH/quote --recursive
enter

echo "Use field selectors to find pods on the worker1 node:"
echo ""
echo "kubectl get pods --field-selector spec.nodeName=worker1 -o wide -n=chp10-set1032b | sort"
echo ""
kubectl get pods --field-selector spec.nodeName=worker1 -o wide -n=chp10-set1032b | sort

echo $HR 

echo "Using custom columns to more UI control:"
echo ""
echo "kubectl get pods -n=chp10-set1032b --field-selector spec.nodeName=worker1 -o=custom-columns='NAME:.metadata.name,Namespace:.metadata.namespace,Node:.spec.nodeName' | sort"
echo ""
kubectl get pods -n=chp10-set1032b --field-selector spec.nodeName=worker1 -o=custom-columns='NAME:.metadata.name,Namespace:.metadata.namespace,Node:.spec.nodeName' | sort

enter

echo "Find pods that are not running:"
echo ""
echo "kubectl get pods --field-selector status.phase!=Running -n=chp10-set1032b"
echo ""
kubectl get pods --field-selector status.phase!=Running -n=chp10-set1032b

echo $HR 

echo "List non-running pods in all namespaces:"
echo ""
echo "kubectl get pods --field-selector status.phase!=Running -A"
echo ""
kubectl get pods --field-selector status.phase!=Running -A

echo $HR 

echo "kubectl get events -n=chp10-set1032b"
kubectl get events -n=chp10-set1032b

enter_delete

echo "kubectl delete ns chp10-set1032b"
kubectl delete ns chp10-set1032b

echo $HR_TOP