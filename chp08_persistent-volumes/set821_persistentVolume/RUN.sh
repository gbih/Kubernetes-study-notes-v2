#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set821_namespace.yaml"
kubectl apply -f $FULLPATH/set821_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set821_pod.yaml"
kubectl apply -f $FULLPATH/set821_pod.yaml
echo $HR 

echo "kubectl apply -f $FULLPATH/set821_pv.yaml"
kubectl apply -f $FULLPATH/set821_pv.yaml
echo $HR 

# Still not possible to pass arbitrary jsonpath to kubectl wait?
# https://github.com/kubernetes/kubernetes/issues/83094
echo "Wait for PV status to be Available:"
until kubectl get pv/quiz-data --output=jsonpath='{.status.phase}' | grep "Available"; do : echo "PV Status: " kubectl get pv/quiz-data --output=jsonpath='{.status.phase}'; done
# while [[ $(kubectl get pv/quiz-data -o 'jsonpath={..status.phase}') != "Available" ]]; do echo "waiting for PV status" && sleep 1; done
echo $HR 

# echo "kubectl get pv quiz-data -o wide"
# kubectl get pv quiz-data -o wide
# echo $HR 

echo "kubectl describe pv quiz-data"
kubectl describe pv quiz-data

enter

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp08-set821 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp08-set821 --timeout=120s
echo $HR

echo "kubectl get all -n=chp08-set821 -o wide"
kubectl get all -n=chp08-set821 -o wide
echo $HR

echo "kubectl delete pv quiz-data"
kubectl delete pv quiz-data
echo $HR

echo "kubectl delete ns chp08-set821"
kubectl delete ns chp08-set821

echo $HR_TOP