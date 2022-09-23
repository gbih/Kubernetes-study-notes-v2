#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1413_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1413 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1413 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

echo "kubectl apply -f $FULLPATH/set1413_deployment_kiada.yaml"
kubectl apply -f $FULLPATH/set1413_deployment_kiada.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1413"
kubectl rollout status deployment kiada -n=chp14-set1413
enter

echo "kubectl get deploy kiada -n=chp14-set1413 -o wide"
kubectl get deploy kiada -n=chp14-set1413 -o wide
echo $HR

echo "kubectl get rs -n=chp14-set1413 --show-labels"
kubectl get rs -n=chp14-set1413 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime

enter

#####

echo "Delete a Deployment, while keeping the underlying ReplicaSet and Pods:"
echo ""

echo "kubectl delete deploy kiada -n=chp14-set1413 --cascade=orphan"
kubectl delete deploy kiada -n=chp14-set1413 --cascade=orphan
echo $HR 

echo "sleep 3"
sleep 3
echo ""

echo "kubectl get rs -n=chp14-set1413 --show-labels"
kubectl get rs -n=chp14-set1413 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime

enter

echo "Adopt an existing ReplicaSet and Pods. We create a Deployment that matches the ReplicaSet that the controller would otherwise create."
echo ""
echo "kubectl apply -f $FULLPATH/set1413_deployment_kiada.yaml"
kubectl apply -f $FULLPATH/set1413_deployment_kiada.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1413"
kubectl rollout status deployment kiada -n=chp14-set1413
echo $HR 

echo "kubectl get rs -n=chp14-set1413 --show-labels"
kubectl get rs -n=chp14-set1413 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime

enter

echo "Delete a Deployment and its underlying ReplicaSet and Pods:"
echo ""

echo "kubectl delete deploy kiada -n=chp14-set1413"
kubectl delete deploy kiada -n=chp14-set1413 
echo $HR 

echo "kubectl get rs -n=chp14-set1413 --show-labels"
kubectl get rs -n=chp14-set1413 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime
echo $HR 

echo "sleep 3"
sleep 3
echo ""

echo "kubectl get rs -n=chp14-set1413 --show-labels"
kubectl get rs -n=chp14-set1413 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1413 -l app=kiada,rel=stable --show-labels --sort-by=.status.startTime

##### Clean-up

enter_delete

echo "kubectl delete ns chp14-set1413"
kubectl delete ns chp14-set1413

echo $HR_TOP