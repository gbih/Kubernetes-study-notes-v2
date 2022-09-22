#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1331_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1331 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp13-set1331 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp13-set1331 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp13-set1331 --timeout=120s
echo $HR 

enter

##### Main

echo "kubectl apply -f $FULLPATH/set1331_replicaset.yaml"
kubectl apply -f $FULLPATH/set1331_replicaset.yaml
echo $HR

echo "kubectl get rs -n=chp13-set1331 -o wide"
kubectl get rs -n=chp13-set1331 -o wide
echo $HR 

echo "Show a single pod created directly via the kiada ReplicaSet:"
echo ""
echo 'rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1331 -o name | head -1)'
rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp13-set1331 -o name | head -1)
echo $rs_pod
echo $HR

echo "kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1331 --timeout=120s"
kubectl wait --for=condition=Ready=True $rs_pod -n=chp13-set1331 --timeout=120s
echo $HR

echo "Use labels to list Pods in this kiada ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada -n=chp13-set1331 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada -n=chp13-set1331 --show-labels --sort-by=.status.startTime
enter

### Delete the pods managed by the ReplicaSet

echo "Delete the pods managed by the ReplicaSet:"
echo ""
echo "kubectl delete pods -l app=kiada -n=chp13-set1331"
kubectl delete pods -l app=kiada -n=chp13-set1331
echo $HR

sleep 1

echo "See the ReplicaSet immediately reconcile the actual state (0 pods) with desired state (5 pods):"
echo ""
echo "kubectl get pods -l app=kiada -n=chp13-set1331 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada -n=chp13-set1331 --show-labels --sort-by=.status.startTime
enter

#####

echo "Create a Pod that matches the ReplicaSet's label selector. This implies there will be one Pod too many."
echo ""

echo "kubectl apply -f $FULLPATH/set1331_pod_one_too_many.yaml"
kubectl apply -f $FULLPATH/set1331_pod_one_too_many.yaml
echo $HR

echo "Check how this pod is immediately removed by the ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada -n=chp13-set1331 --sort-by=.status.startTime -o wide"
kubectl get pods -l app=kiada -n=chp13-set1331 --sort-by=.status.startTime -o wide
enter

echo "Check when pods do not get replaced."
echo "Pods whose containers continually crash or fail their probes are never automatically deleted."
echo ""
echo "kubectl exec rs/kiada -n=chp13-set1331 -c kiada -- curl -X POST localhost:9901/healthcheck/fail"
kubectl exec rs/kiada -n=chp13-set1331 -c kiada -- curl -X POST localhost:9901/healthcheck/fail
echo $HR 

echo "kubectl get pods -n=chp13-set1331 -l app=kiada"
kubectl get pods -n=chp13-set1331 -l app=kiada
echo $HR

echo "kubectl get all -n=chp13-set1331"
kubectl get all -n=chp13-set1331

##### Clean-up

enter_delete

echo "kubectl delete ns chp13-set1331"
kubectl delete ns chp13-set1331

echo $HR_TOP