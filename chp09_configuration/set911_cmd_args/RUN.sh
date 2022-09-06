#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set911_namespace.yaml
kubectl apply -f $FULLPATH/set911_pod_01_cmd.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set911 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set911 --timeout=120s
echo $HR

echo "kubectl get all -n=chp09-set911 -o wide"
kubectl get all -n=chp09-set911 -o wide
echo $HR

echo "kubectl logs pods/kiada -n=chp09-set911"
kubectl logs pods/kiada -n=chp09-set911
echo $HR 

echo "kubectl delete pods/kiada -n=chp09-set911"
kubectl delete pods/kiada -n=chp09-set911
echo $HR


echo "kubectl wait --for=delete pod/kiada -n=chp09-set911 --timeout=60s"
kubectl wait --for=delete pod/kiada -n=chp09-set911 --timeout=60s


echo "kubectl apply -f $FULLPATH/set911_pod_02_args.yaml"
kubectl apply -f $FULLPATH/set911_pod_02_args.yaml
echo $HR

echo "kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set911 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set911 --timeout=120s
echo $HR

echo "kubectl get all -n=chp09-set911 -o wide"
kubectl get all -n=chp09-set911 -o wide
echo $HR

echo "kubectl logs pods/kiada -n=chp09-set911"
kubectl logs pods/kiada -n=chp09-set911
echo $HR 


echo "kubectl delete ns chp09-set911"
kubectl delete ns chp09-set911

echo $HR_TOP