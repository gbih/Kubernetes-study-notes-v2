#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set822_namespace.yaml"
kubectl apply -f $FULLPATH/set822_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set822_pod.yaml"
kubectl apply -f $FULLPATH/set822_pod.yaml
echo $HR 

echo "kubectl apply -f $FULLPATH/set822_pv_quizdata.yaml"
kubectl apply -f $FULLPATH/set822_pv_quizdata.yaml
echo $HR 

echo "kubectl apply -f $FULLPATH/set822_pv_otherdata.yaml"
kubectl apply -f $FULLPATH/set822_pv_otherdata.yaml
echo $HR 

echo "kubectl apply -f $FULLPATH/set822_pvc.yaml"
kubectl apply -f $FULLPATH/set822_pvc.yaml
echo $HR 


# Still not possible to pass arbitrary jsonpath to kubectl wait?
# https://github.com/kubernetes/kubernetes/issues/83094
# echo "Wait for PV quiz-data status to be Available:"
# until kubectl get pv/quiz-data --output=jsonpath='{.status.phase}' | grep "Available"; do : echo "PV Status: " kubectl get pv/quiz-data --output=jsonpath='{.status.phase}'; done
# echo $HR 

# echo "Wait for PV other-data status to be Available:"
# until kubectl get pv/other-data --output=jsonpath='{.status.phase}' | grep "Available"; do : echo "PV Status: " kubectl get pv/quiz-other --output=jsonpath='{.status.phase}'; done
# echo $HR 

echo "kubectl get pv -o wide"
kubectl get pv -o wide

enter

echo "Wait for PVC status to be Bound:"
until kubectl get pvc/quiz-data -n=chp08-set822 --output=jsonpath='{.status.phase}' | grep "Bound"; do : kubectl get pvc/quiz-data -n=chp08-set822 --output=jsonpath='{.status.phase}' ; done
echo $HR 


echo "kubectl get pvc/quiz-data -n=chp08-set822"
kubectl get pvc -n=chp08-set822
echo $HR

echo "kubectl describe pvc/quiz-data -n=chp08-set822"
kubectl describe pvc -n=chp08-set822

enter

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp08-set822 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp08-set822 --timeout=120s
echo $HR

echo "kubectl get all -n=chp08-set822 -o wide"
kubectl get all -n=chp08-set822 -o wide
echo $HR

echo "kubectl delete pvc quiz-data -n=chp08-set822"
kubectl delete pvc quiz-data -n=chp08-set822
echo $HR

echo "kubectl delete pv quiz-data"
kubectl delete pv quiz-data
echo $HR

echo "kubectl delete pv other-data"
kubectl delete pv other-data
echo $HR



echo "kubectl delete ns chp08-set822"
kubectl delete ns chp08-set822

echo $HR_TOP