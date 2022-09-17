#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1121_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1121 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1121 --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1121 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1121 --timeout=120s

echo $HR 

kubectl apply -f $FULLPATH/set1121_svc_nodeport_kiada.yaml
kubectl apply -f $FULLPATH/set1121_svc_quote.yaml
kubectl apply -f $FULLPATH/set1121_svc_quiz.yaml

echo $HR 

echo "kubectl get pods -n=chp11-set1121 -o wide --show-labels | sort"
kubectl get pods -n=chp11-set1121 -o wide --show-labels | sort
echo $HR 

echo "kubectl get svc -n=chp11-set1121 -o wide"
kubectl get svc -n=chp11-set1121 -o wide
echo $HR

echo "kubectl get nodes -o wide"
kubectl get nodes -o wide
echo $HR

sleep 2

enter

node_IP=$(kubectl get svc kiada -n=chp11-set1121 --no-headers -o custom-columns=":spec.clusterIP")
echo "node_ip" $node_IP
echo $HR

echo "curl $node_IP"
curl $node_IP

enter

enter_delete

echo "kubectl delete ns chp11-set1121"
kubectl delete ns chp11-set1121

echo $HR_TOP