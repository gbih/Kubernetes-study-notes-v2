#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1311_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1311 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1311 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp13-set1311 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp13-set1311 --timeout=120s
echo $HR 

# echo "kubectl get all -n=chp13-set1311"
# kubectl get all -n=chp13-set1311

enter

##### Main

echo "kubectl apply -f $FULLPATH/set1311_replicaset.yaml"
kubectl apply -f $FULLPATH/set1311_replicaset.yaml
echo $HR


# How to wait for a ReplicaSet pod to reach Ready status?

# Material from 13.1.2

echo "kubectl get rs -n=chp13-set1311 -o wide"
kubectl get rs -n=chp13-set1311 -o wide
echo $HR 

echo "Use labels to list Pods in this kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp13-set1311 --show-labels"
kubectl get pods -l app=kiada,rel=stable -n=chp13-set1311 --show-labels
echo $HR

echo "Use labels to list only pods created directly via the kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1311 --show-labels"
kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1311 --show-labels
echo $HR

echo "Show a single pod created directly via the kiada ReplicaSet:"
echo ""
echo 'rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1311 -o name | head -1)'
rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1311 -o name | head -1)
echo $rs_pod
echo $HR

echo "kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1311 --timeout=120s"
kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1311 --timeout=120s
echo $HR 

echo "kubectl get $rs_pod -n=chp13-set1311 -o yaml | head -20"
kubectl get $rs_pod -n=chp13-set1311 -o yaml | head -20
enter

echo "Display the logs of the ReplicaSet's pods, for container kiada"
echo ""
echo "kubectl logs rs/kiada -c kiada --prefix -n=chp13-set1311"
kubectl logs rs/kiada -c kiada --prefix -n=chp13-set1311 
enter

echo "Display the logs of the ReplicaSet's pods, for all containers"
echo ""
echo "kubectl logs -l app=kiada -c envoy --prefix -n=chp13-set1311"
kubectl logs -l app=kiada -c envoy --prefix -n=chp13-set1311

##### Clean-up

enter_delete

echo "kubectl delete ns chp13-set1311"
kubectl delete ns chp13-set1311

echo $HR_TOP