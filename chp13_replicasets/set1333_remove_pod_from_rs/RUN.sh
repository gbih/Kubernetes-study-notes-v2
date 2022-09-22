#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1333_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1333 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1333 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

##### Main

echo "kubectl apply -f $FULLPATH/set1333_replicaset.yaml"
kubectl apply -f $FULLPATH/set1333_replicaset.yaml

enter

echo "kubectl get rs -n=chp13-set1333 -o wide"
kubectl get rs -n=chp13-set1333 -o wide
echo $HR 

echo "Show a single pod created directly via the kiada ReplicaSet:"
echo ""
echo 'rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1333 -o name | head -1)'
rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1333 -o name | head -1)
echo $rs_pod
echo $HR

echo "kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1333 --timeout=120s"
kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1333 --timeout=120s
echo $HR

echo "Use labels to list Pods in this kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada -n=chp13-set1333 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada -n=chp13-set1333 --show-labels --sort-by=.status.startTime
enter

#####

echo "Create a broken pod."
echo "Pods whose containers continually crash or fail their probes are never automatically deleted."
echo ""

echo "kubectl exec $rs_pod -n=chp13-set1333 -c kiada -- curl -s -X POST localhost:9901/healthcheck/fail"
kubectl exec $rs_pod -n=chp13-set1333 -c kiada -- curl -s -X POST localhost:9901/healthcheck/fail
echo $HR 

echo "kubectl wait --for=condition=Ready=False $rs_pod -n=chp13-set1333 --timeout=120s"
kubectl wait --for=condition=Ready=False $rs_pod -n=chp13-set1333 --timeout=120s
echo $HR 

echo "kubectl get pods -n=chp13-set1333 -l app=kiada --sort-by=.status.phase "
kubectl get pods -n=chp13-set1333 -l app=kiada --sort-by=.status.phase 
echo $HR
enter

echo "Change the value of the rel label to 'debug'":
echo ""
echo "kubectl label $rs_pod rel=debug -n=chp13-set1333 --overwrite"
kubectl label $rs_pod rel=debug -n=chp13-set1333 --overwrite
echo $HR 

sleep 3

echo "kubectl get pods -n=chp13-set1333 -l app=kiada --show-labels --sort-by=.status.phase"
kubectl get pods -n=chp13-set1333 -l app=kiada --show-labels --sort-by=.status.phase
enter

echo "Deleting a ReplicaSet"
echo ""
echo "kubectl delete replicaset kiada -n=chp13-set1333"
kubectl delete replicaset kiada -n=chp13-set1333
echo $HR 

sleep 3

echo "kubectl get pods -n=chp13-set1333 -l app=kiada --show-labels --sort-by=.status.phase"
kubectl get pods -n=chp13-set1333 -l app=kiada --show-labels --sort-by=.status.phase

##### Clean-up

enter_delete

echo "kubectl delete ns chp13-set1333"
kubectl delete ns chp13-set1333

echo $HR_TOP