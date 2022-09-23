#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1412_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1412 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1412 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

echo "kubectl apply -f $FULLPATH/set1412_deployment_kiada.yaml"
kubectl apply -f $FULLPATH/set1412_deployment_kiada.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1412"
kubectl rollout status deployment kiada -n=chp14-set1412
enter

echo "kubectl get deploy kiada -n=chp14-set1412 -o wide"
kubectl get deploy kiada -n=chp14-set1412 -o wide
echo $HR

echo "Examine the underlying ReplicaSet belonging to this kiada Deployment:"
echo ""
echo "kubectl get rs -n=chp14-set1412 -o wide"
kubectl get rs -n=chp14-set1412 -o wide
echo $HR 

echo "List Pods that belong to the kiada Deployment. See how they are named after the ReplicaSet:"
echo ""
echo "kubectl get pods -l app=kiada,rel=stable -n=chp14-set1412 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp14-set1412 --show-labels --sort-by=.status.startTime
enter

echo "Scale the Deployment to 5 replicas:"
echo ""

echo "kubectl scale deploy kiada -n=chp14-set1412 --replicas 5"
kubectl scale deploy kiada -n=chp14-set1412 --replicas 5
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1412"
kubectl rollout status deployment kiada -n=chp14-set1412
echo $HR 

echo "kubectl get deploy kiada -n=chp14-set1412 -o wide"
kubectl get deploy kiada -n=chp14-set1412 -o wide
echo $HR

echo "kubectl get pods -l app=kiada,rel=stable -n=chp14-set1412 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp14-set1412 --show-labels --sort-by=.status.startTime
enter

#####

echo "Scaling a deployment by accident, Part 1. Our new manifest file mistakenly contains 'replicas: 3'"
echo ""
echo "kubectl apply -f $FULLPATH/set1412_deployment_kiada_labelled.yaml"
kubectl apply -f $FULLPATH/set1412_deployment_kiada_labelled.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1412"
kubectl rollout status deployment kiada -n=chp14-set1412
echo $HR 

echo "kubectl get deploy kiada -n=chp14-set1412 -o wide"
kubectl get deploy kiada -n=chp14-set1412 -o wide
echo $HR

echo "kubectl get pods -l app=kiada,rel=stable -n=chp14-set1412 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp14-set1412 --show-labels --sort-by=.status.startTime
enter

#####

echo "Scaling a deployment by accident, Part 2. Our new manifest file now omits the 'replicas' field, in which case the Kubernetes a default 'replicas: 3'"
echo ""
echo "kubectl apply -f $FULLPATH/set1412_deployment_kiada_noReplicas.yaml"
kubectl apply -f $FULLPATH/set1412_deployment_kiada_noReplicas.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1412"
kubectl rollout status deployment kiada -n=chp14-set1412
echo $HR 

echo "kubectl get deploy kiada -n=chp14-set1412 -o wide"
kubectl get deploy kiada -n=chp14-set1412 -o wide
echo $HR

echo "kubectl get pods -l app=kiada,rel=stable -n=chp14-set1412 --show-labels --sort-by=.status.startTime"
kubectl get pods -l app=kiada,rel=stable -n=chp14-set1412 --show-labels --sort-by=.status.startTime


##### Clean-up

enter_delete

echo "kubectl delete ns chp14-set1412"
kubectl delete ns chp14-set1412

echo $HR_TOP