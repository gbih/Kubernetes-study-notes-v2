#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

#####

echo "Check possible nodes accessible:"
echo "kubectl get nodes -o wide"
echo ""
kubectl get nodes -o wide
echo $HR

echo "Emulate the installation of the SSD in the main node (not the worker node):"
echo ""
echo "sudo rm -fr /mnt/ssd1" # If necessary
sudo rm -fr /mnt/ssd1
echo "sudo mkdir -p /mnt/ssd1"
sudo mkdir -p /mnt/ssd1
echo "sudo chmod 666 /mnt/ssd1"
sudo chmod 666 /mnt/ssd1
echo "ls -l /mnt/ssd1"
ls -l /mnt/ssd1

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

echo "kubectl wait --for=condition=Ready=True pods/mongodb-local -n=chp08-set841 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/mongodb-local -n=chp08-set841 --timeout=120s
echo $HR

echo "kubectl get pod pods/mongodb-local -n=chp08-set841 -o wide"
kubectl get pods/mongodb-local -n=chp08-set841 -o wide

echo "kubectl get pv -o wide"
kubectl get pv -o wide
enter


echo "kubectl delete pods/mongodb-local -n=chp08-set841"
kubectl delete pods/mongodb-local -n=chp08-set841
echo $HR 

kubectl apply -f $FULLPATH/set841_pod.yaml

echo "kubectl wait --for=condition=Ready=True pods/mongodb-local -n=chp08-set841 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/mongodb-local -n=chp08-set841 --timeout=120s
echo $HR

echo "kubectl get pod pods/mongodb-local -n=chp08-set841 -o wide"
kubectl get pods/mongodb-local -n=chp08-set841 -o wide
echo $HR 

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