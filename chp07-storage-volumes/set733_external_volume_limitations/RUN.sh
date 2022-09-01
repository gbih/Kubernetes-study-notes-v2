#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP


echo "kubectl apply -f $FULLPATH/set733_namespace.yaml"
kubectl apply -f $FULLPATH/set733_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set733_pod.yaml"
kubectl apply -f $FULLPATH/set733_pod.yaml
echo $HR 


echo "kubectl apply -f $FULLPATH/set733_pod2.yaml"
kubectl apply -f $FULLPATH/set733_pod2.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp07-set733 --timeout=20s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp07-set733 --timeout=20s
echo $HR

echo "kubectl wait --for=condition=Ready=True pods/quiz2 -n=chp07-set733 --timeout=20s"
kubectl wait --for=condition=Ready=True pods/quiz2 -n=chp07-set733 --timeout=20s
echo $HR

echo "kubectl get all -n=chp07-set733 -o wide"
kubectl get all -n=chp07-set733 -o wide
echo $HR

enter


echo "kubectl describe pod quiz -n=chp07-set733"
kubectl describe pod quiz -n=chp07-set733
enter

echo "kubectl describe pod quiz2 -n=chp07-set733"
kubectl describe pod quiz2 -n=chp07-set733
echo $HR

echo "kubectl delete ns chp07-set733"
kubectl delete ns chp07-set733

echo $HR_TOP