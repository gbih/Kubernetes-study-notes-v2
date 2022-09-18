#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1152_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1152 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1152 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""

kubectl apply -f $FULLPATH/set1152_svc_loadbalancer_kiada.yaml
kubectl apply -f $FULLPATH/set1152_svc_quote.yaml
kubectl apply -f $FULLPATH/set1152_svc_quiz.yaml
echo $HR 

echo "kubectl apply -f $FULLPATH/dns-test.yaml"
kubectl apply -f $FULLPATH/dns-test.yaml
echo ""
echo "kubectl wait --for=condition=Ready=True pods/dns-test -n=chp11-set1152 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/dns-test -n=chp11-set1152 --timeout=120s
enter

# https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/

echo "List nodes in cluster"
echo ""
echo "kubectl get nodes --show-labels"
kubectl get nodes --show-labels
echo $HR

echo "Add labels to nodes"
echo ""

echo "kubectl label nodes main kubernetes.io/zone=zone-main"
kubectl label nodes main kubernetes.io/zone=zone-main
echo ""

echo "kubectl label nodes worker1 kubernetes.io/zone=zone-worker1"
kubectl label nodes worker1 kubernetes.io/zone=zone-worker1
echo $HR

echo "Check nodes again:"
echo ""
echo "kubectl get nodes -L kubernetes.io/zone"
kubectl get nodes -L kubernetes.io/zone
echo $HR 

echo "kubectl get endpointslices -n chp11-set1152"
kubectl get endpointslices -n chp11-set1152
enter

echo "kubectl get endpointslices -n chp11-set1152 -o name| grep kiada"
eps=$(kubectl get endpointslices -n chp11-set1152 -o name| grep kiada)
echo $eps
echo $HR

echo "kubectl get $eps -n=chp11-set1152 -o yaml"
kubectl get $eps -n=chp11-set1152 -o yaml

enter_delete

echo "kubectl delete ns chp11-set1152"
kubectl delete ns chp11-set1152

echo $HR_TOP