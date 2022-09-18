#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1151_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1151 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1151 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo $HR

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1151 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1151 --timeout=120s
echo $HR

kubectl apply -f $FULLPATH/set1151_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1151_svc_internal_traffic_cluster.yaml
kubectl apply -f $FULLPATH/set1151_svc_internal_traffic_local.yaml
echo $HR 

echo "kubectl get svc -n=chp11-set1151 -o wide"
kubectl get svc -n=chp11-set1151 -o wide
echo $HR

echo "kubectl get pod/kiada-001 -n=chp11-set1151 -o wide"
kubectl get pod/kiada-001 -n=chp11-set1151 -o wide
enter

echo "Cluster-level traffic routing"
echo "Use curl to connect to the quote-cluster service from pod kiada-001."
echo '"Cluster" routes internal traffic to a Service to all endpoints.'
echo "Use this setting first: internalTrafficPolicy: Cluster"
echo ""
echo 'kubectl exec -it pod/kiada-001 -n=chp11-set1151 -c kiada --request-timeout=3s -- bash -c "for i in {1..10}; do curl --max-time 2 quote-cluster; done"'
echo ""
kubectl exec -it pod/kiada-001 -n=chp11-set1151 -c kiada --request-timeout=3s -- bash -c "for i in {1..10}; do curl --max-time 2 quote-cluster; done"

enter

echo "Node-local traffic routing"
echo ""
echo "Use curl to connect to the quote-local service from pod kiada-001"
echo '"Local" routes traffic to node-local endpoints only, traffic is dropped if no node-local endpoints are ready.'
echo "Use this setting first: internalTrafficPolicy: Local"
echo ""
echo 'kubectl exec -it pod/kiada-001 -n=chp11-set1151 -c kiada -- bash -c "for i in {1..10}; do curl --max-time 2 quote-local; done"'
echo ""
kubectl exec -it pod/kiada-001 -n=chp11-set1151 -c kiada -- bash -c "for i in {1..10}; do curl --max-time 2 quote-local; done"

enter_delete

echo "kubectl delete ns chp11-set1151"
kubectl delete ns chp11-set1151

echo $HR_TOP