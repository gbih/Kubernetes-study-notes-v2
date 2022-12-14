#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set821_namespace.yaml
kubectl apply -f $FULLPATH/set821_pv_quizdata.yaml
kubectl apply -f $FULLPATH/set821_pv_otherdata.yaml

echo $HR

# Still not possible to pass arbitrary jsonpath to kubectl wait?
# https://github.com/kubernetes/kubernetes/issues/83094
echo "Wait for PV quiz-data status to be Available:"
until kubectl get pv/quiz-data --output=jsonpath='{.status.phase}' | grep "Available"; do : echo "PV Status: " kubectl get pv/quiz-data --output=jsonpath='{.status.phase}'; done
echo $HR 

echo "Wait for PV other-data status to be Available:"
until kubectl get pv/other-data --output=jsonpath='{.status.phase}' | grep "Available"; do : echo "PV Status: " kubectl get pv/quiz-other --output=jsonpath='{.status.phase}'; done
echo $HR 

echo "kubectl get pv -o wide"
kubectl get pv -o wide

enter

echo "kubectl describe pv/quiz-data"
kubectl describe pv/quiz-data

enter

echo "kubectl explain pv.spec"
kubectl explain pv.spec

enter_delete

echo "kubectl delete $(kubectl get pv -o name)"
kubectl delete $(kubectl get pv -o name)
echo $HR

echo "kubectl delete ns chp08-set821"
kubectl delete ns chp08-set821

echo $HR_TOP