#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

#####

echo "Check version of microk8s installed:"
echo "snap info microk8s | grep tracking"
snap info microk8s | grep tracking
echo $HR

echo "Make sure this namespace is clear beforehand"

NS=$(kubectl get ns/chp08-set841 -o name)
if [ $NS == 'namespace/chp08-set834' ]
then
	kubectl delete ns chp08-set841
fi

echo $HR 

#####

echo "Check possible nodes accessible:"
echo "kubectl get nodes -o wide"
echo ""
kubectl get nodes -o wide
echo $HR

kubectl apply -f $FULLPATH/set841_namespace.yaml
kubectl apply -f $FULLPATH/set841_sc_no_provisioner.yaml
kubectl apply -f $FULLPATH/set841_pv.yaml

echo $HR

echo "Inspect the StorageClass"
echo "Local volumes do not currently support dynamic provisioning, however a StorageClass should still be created to delay volume binding until Pod scheduling. This is specified by the WaitForFirstConsumer volume binding mode."
echo ""
echo "kubectl get sc local"
kubectl get sc local
echo $HR 

echo "This PV represents a local disk attached to the worker1 node."
echo "It refers to the local storage class that we created previously."
echo "Unlike previous persistent volumes, this volume represents storage space that is directly attached to the node."
echo "Therefore, we specify that it is a local volume."
echo ""
echo "kubectl get pv -o wide"
kubectl get pv -o wide

enter

echo "Create pod and claim local persistent volume:"
echo ""
kubectl apply -f $FULLPATH/set841_pvc.yaml
kubectl apply -f $FULLPATH/set841_pod.yaml

echo "kubectl wait --for=condition=Ready=True pods/mongodb-local -n=chp08-set841 --timeout=30s"
kubectl wait --for=condition=Ready=True pods/mongodb-local -n=chp08-set841 --timeout=30s
enter

echo "kubectl get pod pods/mongodb-local -n=chp08-set841 -o wide"
kubectl get pods/mongodb-local -n=chp08-set841 -o wide
echo $HR 

echo "kubectl get pvc -n=chp08-set841 -o wide"
kubectl get pvc -n=chp08-set841 -o wide
echo $HR 

echo "kubectl get pv -o wide"
kubectl get pv -o wide
echo $HR 

echo "kubectl get events -n=chp08-set841"
kubectl get events -n=chp08-set841

enter_delete

echo "kubectl delete sc local"
kubectl delete sc local
echo $HR 

echo "kubectl delete ns chp08-set841"
kubectl delete ns chp08-set841

echo $HR_TOP