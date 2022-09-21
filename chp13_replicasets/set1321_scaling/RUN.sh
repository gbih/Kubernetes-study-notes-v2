#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1321_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1321 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1321 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp13-set1321 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp13-set1321 --timeout=120s
echo $HR 

enter

##### Main

echo "kubectl apply -f $FULLPATH/set1321_replicaset.yaml"
kubectl apply -f $FULLPATH/set1321_replicaset.yaml
echo $HR

echo "kubectl get rs -n=chp13-set1321 -o wide"
kubectl get rs -n=chp13-set1321 -o wide
echo $HR 

echo "Show a single pod created directly via the kiada ReplicaSet:"
echo ""
echo 'rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1321 -o name | head -1)'
rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1321 -o name | head -1)
echo $rs_pod
echo $HR

echo "kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1321 --timeout=120s"
kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1321 --timeout=120s
echo $HR

echo "Use labels to list Pods in this kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime
enter

#####

echo "Scale up the ReplicaSet to 6 pods:"
echo ""
echo "kubectl scale rs kiada --replicas 6 -n=chp13-set1321"
kubectl scale rs kiada --replicas 6 -n=chp13-set1321
echo $HR

sleep 2

echo "kubectl get rs -n=chp13-set1321 -o wide"
kubectl get rs -n=chp13-set1321 -o wide
echo $HR 

echo "Use labels to list Pods in this kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime
enter

#####

echo "Scale down the ReplicaSet to 4 pods:"
echo ""
echo "kubectl scale rs kiada --replicas 4 -n=chp13-set1321"
kubectl scale rs kiada --replicas 4 -n=chp13-set1321
echo $HR

sleep 2

echo "kubectl get rs -n=chp13-set1321 -o wide"
kubectl get rs -n=chp13-set1321 -o wide
echo $HR 

echo "Use labels to list Pods in this kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime
enter

#####

echo "Scale down the ReplicaSet to 0 pods:"
echo ""
echo "kubectl scale rs kiada --replicas 0 -n=chp13-set1321"
kubectl scale rs kiada --replicas 0 -n=chp13-set1321
echo $HR

sleep 2

echo "kubectl get rs -n=chp13-set1321 -o wide"
kubectl get rs -n=chp13-set1321 -o wide
echo $HR 

echo "Use labels to list Pods in this kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime
enter

#####

echo "Scale back up the ReplicaSet to 2 pods:"
echo ""
echo "kubectl scale rs kiada --replicas 2 -n=chp13-set1321"
kubectl scale rs kiada --replicas 2 -n=chp13-set1321
echo $HR

sleep 2

echo "kubectl get rs -n=chp13-set1321 -o wide"
kubectl get rs -n=chp13-set1321 -o wide
echo $HR 

echo "Use labels to list Pods in this kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp13-set1321 --show-labels --sort-by=.status.startTime
enter

##### Clean-up

enter_delete

echo "kubectl delete ns chp13-set1321"
kubectl delete ns chp13-set1321

echo $HR_TOP