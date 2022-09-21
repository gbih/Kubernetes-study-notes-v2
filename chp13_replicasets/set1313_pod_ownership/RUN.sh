#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1313_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1313 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1313 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp13-set1313 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp13-set1313 --timeout=120s
echo $HR 

enter

##### Main

echo "kubectl apply -f $FULLPATH/set1313_replicaset.yaml"
kubectl apply -f $FULLPATH/set1313_replicaset.yaml
echo $HR


# Material from 13.1.2

echo "kubectl get rs -n=chp13-set1313 -o wide"
kubectl get rs -n=chp13-set1313 -o wide
echo $HR 

# How to wait for a ReplicaSet pod to reach Ready status?
# You can uses the selector and labels to create a Parent/Dependent relationship,
# search for that, then use the general 'wait --for=condition=Ready=True' mechanism for that pod

echo "Use labels to list Pods in this kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp13-set1313 --show-labels"
kubectl get pods -l app=kiada,rel=stable -n=chp13-set1313 --show-labels
echo $HR

echo "Use labels to list only pods created directly via the kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1313 --show-labels"
kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1313 --show-labels
echo $HR

echo "Show a single pod created directly via the kiada ReplicaSet:"
echo ""
echo 'rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1313 -o name | head -1)'
rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1313 -o name | head -1)
echo $rs_pod
echo $HR

echo "kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1313 --timeout=120s"
kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1313 --timeout=120s
enter

echo "kubectl describe pods kiada-001 -n=chp13-set1313 | head -14"
kubectl describe pods kiada-001 -n=chp13-set1313 | head -14
enter

echo "kubectl get $rs_pod -n=chp13-set1313 -o yaml | head -20"
kubectl get $rs_pod -n=chp13-set1313 -o yaml | head -20
enter

echo "Delete the parent ReplicaSet kiada. This should automatically delete the dependent pod objects."
echo ""
echo "kubectl delete rs kiada -n=chp13-set1313"
kubectl delete rs kiada -n=chp13-set1313
echo $HR 

echo "kubectl get pods -n=chp13-set1313 --show-labels"
kubectl get pods -n=chp13-set1313 --show-labels
echo $HR

echo "kubectl wait --for=condition=Ready=False $rs_pod -n=chp13-set1313 --timeout=120s"
kubectl wait --for=condition=Ready=False $rs_pod -n=chp13-set1313 --timeout=120s
echo $HR

sleep 2

echo "kubectl get pods -n=chp13-set1313 --show-labels"
kubectl get pods -n=chp13-set1313 --show-labels
echo $HR

##### Clean-up

enter_delete

echo "kubectl delete ns chp13-set1313"
kubectl delete ns chp13-set1313

echo $HR_TOP