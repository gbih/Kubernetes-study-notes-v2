#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set611_namespace.yaml"
kubectl apply -f $FULLPATH/set611_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set611_pod.yaml"
kubectl apply -f $FULLPATH/set611_pod.yaml

echo $HR 

echo "POD0=\$(kubectl get pods -n=chp06-set611 -o jsonpath={'.items[0].metadata.name'})"
POD0=$(kubectl get pods -n=chp06-set611 -o jsonpath={'.items[0].metadata.name'})
echo ""

while [[ $(kubectl get pods $POD0 -n=chp06-set611 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]
do
# cannot have spacing at beginning of line in this syntax
kubectl get pods $POD0 -n=chp06-set611 -o custom-columns=\
INITIALIZED:..status.conditions['?(@.type=="Initialized")'].status,\
POD_SCHEDULED:..status.conditions['?(@.type=="PodScheduled")'].status,\
READY:..status.conditions['?(@.type=="Ready")'].status,\
CONTAINERS_READY:..status.conditions['?(@.type=="ContainersReady")'].status
sleep 0.2
done

# print final status
kubectl get pods $POD0 -n=chp06-set611 -o custom-columns=\
INITIALIZED:..status.conditions['?(@.type=="Initialized")'].status,\
POD_SCHEDULED:..status.conditions['?(@.type=="PodScheduled")'].status,\
READY:..status.conditions['?(@.type=="Ready")'].status,\
CONTAINERS_READY:..status.conditions['?(@.type=="ContainersReady")'].status

enter

echo "kubectl describe pod kiada -n=chp06-set611"
kubectl describe pod kiada -n=chp06-set611
echo $HR

echo "kubectl delete ns chp06-set611"
kubectl delete ns chp06-set611