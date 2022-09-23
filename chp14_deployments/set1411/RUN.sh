#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1411_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1411 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1411 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

echo "Show a single pod created directly via the kiada ReplicaSet:"
echo ""
echo 'rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp14-set1411 -o name | head -1)'
rs_pod=$(kubectl get pods -l app=kiada,rel=stable,parent=rs.kiada -n=chp14-set1411 -o name | head -1)
echo $rs_pod
echo $HR

echo "kubectl wait --for=condition=Ready=True $rs_pod -n=chp14-set1411 --timeout=120s"
kubectl wait --for=condition=Ready=True $rs_pod -n=chp14-set1411 --timeout=120s
enter

echo "Delete ReplicaSet but leave its Pods running:"
echo ""
echo "kubectl delete rs kiada -n=chp14-set1411 --cascade=orphan"
kubectl delete rs kiada -n=chp14-set1411 --cascade=orphan
echo $HR

echo "List Pods that now remain:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp14-set1411 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp14-set1411 --show-labels --sort-by=.status.startTime
enter

sleep 1

echo "kubectl apply -f $FULLPATH/set1411_deployment_kiada.yaml"
kubectl apply -f $FULLPATH/set1411_deployment_kiada.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1411"
kubectl rollout status deployment kiada -n=chp14-set1411
echo $HR

echo "kubectl get deploy kiada -n=chp14-set1411 -o wide"
kubectl get deploy kiada -n=chp14-set1411 -o wide
echo $HR

echo "Examine the underlying ReplicaSet belonging to this kiada Deployment:"
echo ""
echo "kubectl get rs -n=chp14-set1411 -o wide"
kubectl get rs -n=chp14-set1411 -o wide
echo $HR 

echo "List Pods that belong to the kiada Deployment. See how they are named after the ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp14-set1411 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp14-set1411 --show-labels --sort-by=.status.startTime
enter


echo "List pods that were not originally created by the kiada ReplicaSet (do not have pod-template-hash label):"
echo ""
echo "kubectl get pods -l 'app=kiada,rel=stable,!pod-template-hash' -n=chp14-set1411 --show-labels --sort-by=.status.startTime"
kubectl get pods -l 'app=kiada,rel=stable,!pod-template-hash' -n=chp14-set1411 --show-labels --sort-by=.status.startTime
echo $HR 


echo "Delete two kiada Pods that aren't part of the Deployment:"
echo ""
echo "kubectl delete pods -l 'app=kiada,rel=stable,!pod-template-hash' -n=chp14-set1411"
kubectl delete pods -l 'app=kiada,rel=stable,!pod-template-hash' -n=chp14-set1411
echo $HR

# echo "kubectl describe rs kiada -n=chp14-set1411"
# kubectl describe rs kiada -n=chp14-set1411
# echo $HR 


echo "kubectl get pods -n=chp14-set1411 -l 'app=kiada,rel=stable' --show-labels --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1411 -l 'app=kiada,rel=stable' --show-labels --sort-by=.status.startTime
echo $HR 

enter

echo "Troubleshooting Deployments that fail to produce any Pods:"
echo ""

echo "kubectl apply -f $FULLPATH/set1411_where-are-the-pods.yaml"
kubectl apply -f $FULLPATH/set1411_where-are-the-pods.yaml
echo $HR 

sleep 3

echo "kubectl get deployment where-are-the-pods -n=chp14-set1411"
kubectl get deployment where-are-the-pods -n=chp14-set1411
echo $HR 

echo "kubectl describe deploy -n=chp14-set1411 | tail -12"
kubectl describe deploy -n=chp14-set1411 | tail -12
echo $HR 

echo "kubectl describe rs where-are-the-pods -n=chp14-set1411 | tail -5"
kubectl describe rs where-are-the-pods -n=chp14-set1411 | tail -5

##### Clean-up

enter_delete

echo "kubectl delete ns chp14-set1411"
kubectl delete ns chp14-set1411

echo $HR_TOP