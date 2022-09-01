#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP


echo "kubectl apply -f $FULLPATH/set742_namespace.yaml"
kubectl apply -f $FULLPATH/set742_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set742_pod.yaml"
kubectl apply -f $FULLPATH/set742_pod.yaml
echo $HR 



echo "kubectl wait --for=condition=Ready=True pods/node-explorer -n=chp07-set742 --timeout=20s"
kubectl wait --for=condition=Ready=True pods/node-explorer -n=chp07-set742 --timeout=20s
echo $HR



echo "kubectl get all -n=chp07-set742 -o wide"
kubectl get all -n=chp07-set742 -o wide
echo $HR

enter

echo "kubectl exec -it node-explorer -n=chp07-set742 -- ls -la /host"
kubectl exec -it node-explorer -n=chp07-set742 -- ls -la /host
echo $HR


echo "kubectl delete ns chp07-set742"
kubectl delete ns chp07-set742

echo $HR_TOP