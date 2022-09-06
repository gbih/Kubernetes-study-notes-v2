#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

#####

echo "Before running anything, make sure we don't have any PV or PVC objects running in cluster."

NS=chp08-set841

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


#####

echo "Check possible nodes accessible:"
echo "kubectl get nodes -o wide"
echo ""
kubectl get nodes -o wide
echo $HR

kubectl apply -f $FULLPATH/set841_namespace.yaml
kubectl apply -f $FULLPATH/set841_storage_class.yaml
kubectl apply -f $FULLPATH/set841_pv.yaml

echo $HR

echo "Inspect the StorageClass"
echo "Local volumes do not currently support dynamic provisioning, however a StorageClass should still be created to delay volume binding until Pod scheduling. This is specified by the WaitForFirstConsumer volume binding mode."
echo ""
echo "kubectl get sc local"
kubectl get sc local
echo $HR 

echo "kubectl get pv -o wide"
kubectl get pv -o wide
enter

echo "Create pod and claim"
kubectl apply -f $FULLPATH/set841_pvc.yaml
kubectl apply -f $FULLPATH/set841_pod.yaml

echo "kubectl wait --for=condition=Ready=True pods/mongodb-local -n=chp08-set841 --timeout=360s"
kubectl wait --for=condition=Ready=True pods/mongodb-local -n=chp08-set841 --timeout=360s
echo $HR

echo "kubectl get pod pods/mongodb-local -n=chp08-set841 -o wide"
kubectl get pods/mongodb-local -n=chp08-set841 -o wide
echo $HR

echo "kubectl get pv -o wide"
kubectl get pv -o wide

echo "Press [ENTER] to delete objects:"
enter

echo "kubectl delete ns chp08-set841"
kubectl delete ns chp08-set841
echo $HR


PV=$(kubectl get pv local-ssd-on-kind-worker -o=name)
echo "PV exists: $PV"
echo "kubectl patch $PV -p '{"metadata":{"finalizers":null}}'"
kubectl patch $PV -p '{"metadata":{"finalizers":null}}'
echo ""
echo "kubectl delete pv $PV --force --grace-period=0"
kubectl delete $PV --force --grace-period=0


echo $HR_TOP