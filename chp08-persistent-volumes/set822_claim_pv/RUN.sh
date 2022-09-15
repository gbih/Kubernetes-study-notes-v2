#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "This cluster has two PVs. Before the quiz pod can use the quiz-data volume, we need to claim it via a PVC."

echo $HR 

kubectl apply -f $FULLPATH/set822_namespace.yaml
kubectl apply -f $FULLPATH/set822_pvc_quizdata.yaml
kubectl apply -f $FULLPATH/set822_pv_quizdata.yaml
kubectl apply -f $FULLPATH/set822_pv_otherdata.yaml

echo $HR

echo "kubectl get pv -o wide"
kubectl get pv -o wide

enter

echo "kubectl get pvc/quiz-data -n=chp08-set822 -o wide"
kubectl get pvc -n=chp08-set822 -o wide
echo $HR

echo "kubectl describe pvc/quiz-data -n=chp08-set822"
kubectl describe pvc -n=chp08-set822

enter

echo "kubectl get pvc/quiz-data -n=chp08-set822 -o yaml"
kubectl get pvc/quiz-data -n=chp08-set822 -o yaml

enter_delete

echo "kubectl delete ns chp08-set822"
kubectl delete ns chp08-set822
echo $HR 

echo "Deleting the PVC will not delete the PV, since we originally creted the PV beforehand"
echo "So, we need to also manually delete the PVs here:"

echo "kubectl delete $(kubectl get pv -o name)"
echo ""
kubectl delete $(kubectl get pv -o name)

echo $HR_TOP