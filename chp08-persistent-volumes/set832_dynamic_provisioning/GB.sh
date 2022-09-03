#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Before running anything, make sure we don't have any PV objects running in cluster."

PVC=$(kubectl get pvc -o=name -A)

NS=chp08-set832

if [ $PVC ]
then
	echo "PVC exists: $PVC"
	echo $HR
	echo "kubectl patch $PVC -n=$NS -p '{metadata:{finalizers:null}}'"
	kubectl patch $PVC -n=$NS -p '{"metadata":{"finalizers":null}}'
	echo $HR
	echo "kubectl delete $PVC -n=$NS --force --grace-period=0"
	kubectl delete $PVC -n=$NS --force --grace-period=0
else
	echo "PVC does not exist."
fi

# kubectl edit persistentvolumeclaim/quiz-data-default -n=chp08-set832

# kubectl patch persistentvolumeclaim/quiz-data-default -n=chp08-set832 -p '{metadata:{finalizers:null}}' 
# #kubectl patch pvc $PVC -p '{"metadata":{"finalizers":null}}' 