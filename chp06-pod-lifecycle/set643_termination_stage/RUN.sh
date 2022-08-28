#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP


echo "kubectl apply -f $FULLPATH/set643_namespace.yaml"
kubectl apply -f $FULLPATH/set643_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set643_pod.yaml"
kubectl apply -f $FULLPATH/set643_pod.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl-shortgraceperiod -n=chp06-set643 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl-shortgraceperiod -n=chp06-set643 --timeout=120s
echo $HR

# echo "kubectl get all -n=chp06-set643 -o wide"
# kubectl get all -n=chp06-set643 -o wide
# echo $HR

start=$SECONDS
echo "Deleting pod: start"
echo "For our pod, we have set 'terminationGracePeriodSeconds: 5'"
echo ""
echo "kubectl delete pod/kiada-ssl-shortgraceperiod -n=chp06-set643"
kubectl delete pod/kiada-ssl-shortgraceperiod -n=chp06-set643
echo ""

duration=$(( SECONDS - start ))
echo "Deleting pod: end"
echo $duration "seconds"
echo $HR

echo "kubectl delete ns chp06-set643"
kubectl delete ns chp06-set643

echo $HR_TOP