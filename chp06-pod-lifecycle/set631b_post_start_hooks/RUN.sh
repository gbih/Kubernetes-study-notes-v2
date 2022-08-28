#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)
echo $FULLPATH

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set631b_namespace.yaml"
kubectl apply -f $FULLPATH/set631b_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set631b_pod.yaml"
kubectl apply -f $FULLPATH/set631b_pod.yaml
echo $HR

echo "POD0=\$(kubectl get pods -n=chp06-set631b -o jsonpath={'.items[0].metadata.name'})"
POD0=$(kubectl get pods -n=chp06-set631b -o jsonpath={'.items[0].metadata.name'})
echo ""

while [[ $(kubectl get pods $POD0 -n=chp06-set631b -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]
do
# cannot have spacing at beginning of line in this syntax
kubectl get pods $POD0 -n=chp06-set631b -o custom-columns=\
POD_SCHEDULED:..status.conditions['?(@.type=="PodScheduled")'].status,\
INITIALIZED:..status.conditions['?(@.type=="Initialized")'].status,\
CONTAINERS_READY:..status.conditions['?(@.type=="ContainersReady")'].status,\
READY:..status.conditions['?(@.type=="Ready")'].status
sleep 0.2
done

# print final status
kubectl get pods $POD0 -n=chp06-set631b -o custom-columns=\
POD_SCHEDULED:..status.conditions['?(@.type=="PodScheduled")'].status,\
INITIALIZED:..status.conditions['?(@.type=="Initialized")'].status,\
CONTAINERS_READY:..status.conditions['?(@.type=="ContainersReady")'].status,\
READY:..status.conditions['?(@.type=="Ready")'].status

echo $HR


echo "Check logs"
echo ""
echo "kubectl logs poststart-httpget -n=chp06-set631b"
kubectl logs poststart-httpget -n=chp06-set631b
echo $HR


echo "kubectl describe pod poststart-httpget -n=chp06-set631b"
kubectl describe pod poststart-httpget -n=chp06-set631b
echo $HR

echo "kubectl delete ns chp06-set631b"
kubectl delete ns chp06-set631b

echo $HR_TOP