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

NS=$(kubectl get ns/chp08-set834 -o name)
if [ $NS == 'namespace/chp08-set834' ]
then
	kubectl delete ns chp08-set834
fi

echo $HR 

echo "Check the StorageClass used. In particular, pay attention to the 'volumeBindingMode' field:"
echo "kubectl get sc"
kubectl get sc

enter

kubectl apply -f $FULLPATH/openebs-hostpath.yaml
kubectl apply -f $FULLPATH/set834_namespace.yaml
kubectl apply -f $FULLPATH/set834_pvc_original.yaml

echo $HR 

echo "Apply pod yaml here:"
echo "kubectl apply -f $FULLPATH/set834_pod-default.yaml"
kubectl apply -f $FULLPATH/set834_pod-default.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quiz-default -n=chp08-set834 --timeout=360s"
kubectl wait --for=condition=Ready=True pods/quiz-default -n=chp08-set834 --timeout=360s
echo $HR

enter

echo "We now should have a dynamically provisioned PV:"
echo ""
echo "kubectl get pv"
kubectl get pv
echo $HR

echo "kubectl get pvc/quiz-data-default -n=chp08-set834"
kubectl get pvc/quiz-data-default -n=chp08-set834
echo $HR 


echo "Request a larger volume via an updated PersistentVolumeClaim"
echo "kubectl apply -f $FULLPATH/set834_pvc_resize.yaml"
kubectl apply -f $FULLPATH/set834_pvc_resize.yaml
echo $HR 

echo "kubectl get pvc/quiz-data-default -n=chp08-set834"
kubectl get pvc/quiz-data-default -n=chp08-set834
echo $HR 

echo "Requesting a different volume size does not work with the microk8s provisioner. We get this error message: Ignoring the PVC: didn't find a plugin capable of expanding the volume; waiting for an external controller to process this PVC."

enter 

echo "kubectl get events -n=chp08-set834"
kubectl get events -n=chp08-set834

enter_delete

echo "kubectl delete ns chp08-set834"
kubectl delete ns chp08-set834

echo $HR_TOP