#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Check version of microk8s installed:"
echo "snap info microk8s | grep tracking"
snap info microk8s | grep tracking
echo $HR

echo "Before running anything, check if we have a running PV object:"
echo "kubectl get pv"
kubectl get pv
echo $HR

echo "kubectl describe pv"
kubectl describe pv
enter

echo "kubectl apply -f $FULLPATH/test_namespace.yaml"
kubectl apply -f $FULLPATH/test_namespace.yaml
enter

echo "kubectl apply -f $FULLPATH/test_pvc.yaml"
kubectl apply -f $FULLPATH/test_pvc.yaml
enter

echo "In a microk8s cluster, the persistent volume claim we create here is not bound immediately, and its status should be 'Pending'."
echo "Here, our claim will remain in the Pending state until we create a pod that uses this claim."
echo ""
echo "kubectl get pvc/test-pvc -n=test"
kubectl get pvc/test-pvc -n=test
enter

echo "kubectl describe pvc/test-pvc -n=test"
kubectl describe pvc/test-pvc -n=test

enter

echo "Apply pod yaml here:"
echo "kubectl apply -f $FULLPATH/test_pod.yaml"
kubectl apply -f $FULLPATH/test_pod.yaml
enter

echo "kubectl wait --for=condition=Ready=True pods/test-nginx -n=test --timeout=120s"
kubectl wait --for=condition=Ready=True pods/test-nginx -n=test --timeout=120s

enter

echo "kubectl get pvc/test-pvc -n=test"
kubectl get pvc/test-pvc -n=test
enter

echo "kubectl get all -n=test -o wide"
kubectl get all -n=test -o wide
enter

echo "kubectl get events -n=test"
kubectl get events -n=test
enter

#####

echo "Press enter to delete objects"
enter


echo "kubectl delete ns test"
kubectl delete ns test

echo $HR_TOP