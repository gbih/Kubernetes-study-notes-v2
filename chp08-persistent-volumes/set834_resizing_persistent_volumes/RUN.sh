#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

#####

echo "Check version of microk8s installed:"
echo "snap info microk8s | grep tracking"
snap info microk8s | grep tracking
echo $HR

echo "Before running anything, make sure we don't have any PV or PVC objects running in cluster."

NS=chp08-set834

echo "kubectl delete ns $NS"
kubectl delete ns $NS
echo $HR 

PV=$(kubectl get pv -o=name)

if [ $PV ]
then
	echo "PV exists: $PV"
	echo "kubectl patch $PV -p '{metadata:{finalizers:null}}'"
	kubectl patch $PV -p '{"metadata":{"finalizers":null}}'
	echo ""
	echo "kubectl delete pv $PV --force --grace-period=0"
	kubectl delete $PV --force --grace-period=0
else
	echo "PV does not exist."
fi

echo $HR

PVC=$(kubectl get pvc -o=name -n=$NS)

if [ $PVC ]
then
	echo "PVC exists: $PVC"
	echo $HR
	echo "kubectl patch $PVC -n=$NS -p '{metadata:{finalizers:null}}'"
	kubectl patch $PVC -n=$NS -p '{"metadata":{"finalizers":null}}'
	echo ""
	echo "kubectl delete $PVC -n=$NS --force --grace-period=0"
	kubectl delete $PVC -n=$NS --force --grace-period=0
else
	echo "PVC does not exist."
fi

echo $HR

#####


echo "kubectl get sc"
kubectl get sc
echo $HR

echo "kubectl get pv"
kubectl get pv
enter

echo "kubectl apply -f $FULLPATH/set834_namespace.yaml"
kubectl apply -f $FULLPATH/set834_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set834_sc_microk8syaml"
kubectl apply -f $FULLPATH/set834_sc_microk8s.yaml
echo $HR


echo "kubectl apply -f $FULLPATH/set834_pvc.yaml"
kubectl apply -f $FULLPATH/set834_pvc.yaml
echo $HR 

echo "kubectl get pvc/quiz-data-default -n=chp08-set834"
kubectl get pvc/quiz-data-default -n=chp08-set834
enter


echo "Apply pod yaml here:"
echo "kubectl apply -f $FULLPATH/set834_pod-default.yaml"
kubectl apply -f $FULLPATH/set834_pod-default.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quiz-default -n=chp08-set834 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz-default -n=chp08-set834 --timeout=120s
echo $HR

enter

echo "We now should have a dynamically provisioned PV:"
echo ""
echo "kubectl get pv"
kubectl get pv
enter


echo "kubectl delete pod/quiz-default -n=chp08-set834"
kubectl delete pod/quiz-default -n=chp08-set834
enter


echo "Requesting a larger volume via a new PVC"
#echo "It appears that the default microk8s-hostpath storageclass that provisions the pvc does not support resize."
echo "kubectl apply -f $FULLPATH/set834_pvc_resize.yaml"
kubectl apply -f $FULLPATH/set834_pvc_resize.yaml

enter

echo "Apply pod yaml here:"
echo "kubectl apply -f $FULLPATH/set834_pod-default.yaml"
kubectl apply -f $FULLPATH/set834_pod-default.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quiz-default -n=chp08-set834 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz-default -n=chp08-set834 --timeout=120s
echo $HR

enter

echo "kubectl get pvc/quiz-data-default -n=chp08-set834"
kubectl get pvc/quiz-data-default -n=chp08-set834
enter


echo "kubectl describe pvc quiz-data-default -n=chp08-set834"
kubectl describe pvc quiz-data-default -n=chp08-set834
echo $HR


echo "kubectl delete ns chp08-set834"
kubectl delete ns chp08-set834
echo $HR

PV=$(kubectl get pv -o=name)
echo "PV exists: $PV"
echo "kubectl patch $PV -p '{"metadata":{"finalizers":null}}'"
kubectl patch $PV -p '{"metadata":{"finalizers":null}}'
echo ""

echo "kubectl delete pv $PV --force --grace-period=0"
kubectl delete $PV --force --grace-period=0


echo $HR_TOP