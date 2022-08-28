#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set631_namespace.yaml"
kubectl apply -f $FULLPATH/set631_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set631_pod.yaml"
kubectl apply -f $FULLPATH/set631_pod.yaml
echo $HR




while [[ $(kubectl get pods $POD0 -n=chp06-set631 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]
do
# cannot have spacing at beginning of line in this syntax
kubectl get pods $POD0 -n=chp06-set631 -o custom-columns=\
POD_SCHEDULED:..status.conditions['?(@.type=="PodScheduled")'].status,\
INITIALIZED:..status.conditions['?(@.type=="Initialized")'].status,\
CONTAINERS_READY:..status.conditions['?(@.type=="ContainersReady")'].status,\
READY:..status.conditions['?(@.type=="Ready")'].status
sleep 0.2
done

# print final status
kubectl get pods $POD0 -n=chp06-set631 -o custom-columns=\
POD_SCHEDULED:..status.conditions['?(@.type=="PodScheduled")'].status,\
INITIALIZED:..status.conditions['?(@.type=="Initialized")'].status,\
CONTAINERS_READY:..status.conditions['?(@.type=="ContainersReady")'].status,\
READY:..status.conditions['?(@.type=="Ready")'].status

enter


echo "Check processes in the container"
echo ""
echo "kubectl exec quote-poststart -n=chp06-set631 -- ps x"
kubectl exec quote-poststart -n=chp06-set631 -- ps x 
echo $HR

echo "kubectl get all -n=chp06-set631 -o wide"
kubectl get all -n=chp06-set631 -o wide
echo $HR

echo "IP=\$(kubectl get pod -n=chp06-set631 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp06-set631 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR


for i in {1..2}
do
	echo "curl $IP:80/quote"
	curl $IP:80/quote
	echo $HR
	sleep 0.5
done


enter_no_clear

echo "Check logs"
echo ""
echo "kubectl logs quote-poststart -n=chp06-set631"
kubectl logs quote-poststart -n=chp06-set631
echo $HR


echo "kubectl delete ns chp06-set631"
kubectl delete ns chp06-set631

echo $HR_TOP