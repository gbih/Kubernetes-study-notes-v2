#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set632_namespace.yaml"
kubectl apply -f $FULLPATH/set632_namespace.yaml
echo $HR


echo "kubectl apply -f $FULLPATH/set632_pod.yaml"
kubectl apply -f $FULLPATH/set632_pod.yaml
echo $HR


echo "POD0=\$(kubectl get pods -n=chp06-set632 -o jsonpath={'.items[0].metadata.name'})"
POD0=$(kubectl get pods -n=chp06-set632 -o jsonpath={'.items[0].metadata.name'})
echo $POD0
echo $HR

while [[ $(kubectl get pods $POD0 -n=chp06-set632 -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]
do
# cannot have spacing at beginning of line in this syntax
kubectl get pods $POD0 -n=chp06-set632 -o custom-columns=\
POD_SCHEDULED:..status.conditions['?(@.type=="PodScheduled")'].status,\
INITIALIZED:..status.conditions['?(@.type=="Initialized")'].status,\
CONTAINERS_READY:..status.conditions['?(@.type=="ContainersReady")'].status,\
READY:..status.conditions['?(@.type=="Ready")'].status
sleep 0.2
done

# print final status
kubectl get pods $POD0 -n=chp06-set632 -o custom-columns=\
POD_SCHEDULED:..status.conditions['?(@.type=="PodScheduled")'].status,\
INITIALIZED:..status.conditions['?(@.type=="Initialized")'].status,\
CONTAINERS_READY:..status.conditions['?(@.type=="ContainersReady")'].status,\
READY:..status.conditions['?(@.type=="Ready")'].status

enter


echo "IP=\$(kubectl get pod -n=chp06-set632 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp06-set632 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR


for i in {1..1}
do
	echo "curl $IP:80/quote"
	curl $IP:80/quote
	echo $HR
	sleep 1
done


echo "Check logs"
echo ""
echo "kubectl logs quote-prestop -n=chp06-set632"
kubectl logs quote-prestop -n=chp06-set632
echo $HR

echo "Press <enter> to delete pod:"
enter_no_clear


echo "kubectl delete pod quote-prestop -n=chp06-set632"
kubectl delete pod quote-prestop -n=chp06-set632
echo $HR

sleep 2

echo "Check events:"
echo "kubectl get events -n=chp06-set632"
kubectl get events -n=chp06-set632
echo $HR

echo "kubectl delete ns chp06-set632"
kubectl delete ns chp06-set632

echo $HR_TOP