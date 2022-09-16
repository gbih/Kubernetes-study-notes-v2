#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

#####

echo "Check version of microk8s installed:"
echo "snap info microk8s | grep tracking"
snap info microk8s | grep tracking
echo $HR

echo "Check the StorageClass used. In particular, pay attention to the 'volumeBindingMode' field:"
echo "kubectl get sc"
kubectl get sc
echo $HR

echo "Make sure this namespace is clear beforehand"

NS=$(kubectl get ns/chp08-set832 -o name)
if [ $NS ==  'namespace/chp08-set832' ]
then
	kubectl delete ns chp08-set832
fi


echo $HR

kubectl apply -f $FULLPATH/set832_namespace.yaml
kubectl apply -f $FULLPATH/set832_pvc.yaml
echo $HR 

echo "In a microk8s cluster, the persistent volume claim we create here is not bound immediately, and its status should be 'Pending'."
echo "Here, our claim will remain in the Pending state until we create a pod that uses this claim."
echo ""
echo "kubectl get pvc/quiz-data-default -n=chp08-set832 -o wide"
kubectl get pvc/quiz-data-default -n=chp08-set832 -o wide
enter

echo "kubectl describe pvc/quiz-data-default -n=chp08-set832"
kubectl describe pvc/quiz-data-default -n=chp08-set832
echo $HR

echo "Check persistent volumes"
echo "kubectl get pv -o wide"
kubectl get pv -o wide

enter

echo "Apply pod yaml here:"
echo "kubectl apply -f $FULLPATH/set832_pod-default.yaml"
kubectl apply -f $FULLPATH/set832_pod-default.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quiz-default -n=chp08-set832 --timeout=360s"
kubectl wait --for=condition=Ready=True pods/quiz-default -n=chp08-set832 --timeout=360s

enter

echo "We now should have a dynamically provisioned PV:"
echo ""
echo "kubectl get pv"
kubectl get pv
enter

echo "kubectl get events -n=chp08-set832"
kubectl get events -n=chp08-set832

enter_delete

#####

echo "Here, PVs are provisioned dynamically via PVCs. Hence deleting the namespace will clear both PVC and PV automatically."
echo ""
echo "kubectl delete ns chp08-set832"
kubectl delete ns chp08-set832
echo $HR


echo $HR_TOP