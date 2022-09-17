#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1122_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1122 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1122 --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1122 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1122 --timeout=120s

echo $HR 

kubectl apply -f $FULLPATH/set1122_svc_loadbalancer_kiada.yaml
kubectl apply -f $FULLPATH/set1122_svc_quote.yaml
kubectl apply -f $FULLPATH/set1122_svc_quiz.yaml

echo $HR 

echo "kubectl get pods -n=chp11-set1122 -o wide --show-labels | sort"
kubectl get pods -n=chp11-set1122 -o wide --show-labels | sort

enter

echo "kubectl get svc -n=chp11-set1122 -o wide"
kubectl get svc -n=chp11-set1122 -o wide
echo $HR

echo "kubectl get nodes -o wide"
kubectl get nodes -o wide
echo $HR

sleep 2

enter
echo "EXTERNAL_IP=$(kubectl get svc kiada -n=chp11-set1122 -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
EXTERNAL_IP=$(kubectl get svc kiada -n=chp11-set1122 -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
#node_IP=$(kubectl get svc kiada -n=chp11-set1122 --no-headers -o custom-columns=":spec.clusterIP")
echo "EXTERNAL_IP" $EXTERNAL_IP
echo $HR

echo "curl $EXTERNAL_IP"
curl $EXTERNAL_IP

enter

enter_delete

echo "kubectl delete ns chp11-set1122"
kubectl delete ns chp11-set1122

echo $HR_TOP