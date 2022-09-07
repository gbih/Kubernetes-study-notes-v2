#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set924b_namespace.yaml
echo $HR 

echo "kubectl create configmap kiada-envoy-config -n=chp09-set924b --from-file=configmap-files"
kubectl create configmap kiada-envoy-config -n=chp09-set924b --from-file=configmap-files
echo $HR

echo "kubectl get cm kiada-envoy-config -n=chp09-set924b"
kubectl get cm kiada-envoy-config -n=chp09-set924b
echo $HR

kubectl apply -f $FULLPATH/set924b_pod.yaml
echo $HR

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set924b --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set924b --timeout=120s
echo $HR

echo "kubectl get pods/kiada-ssl -n=chp09-set924b -o wide"
kubectl get pods/kiada-ssl -n=chp09-set924b -o wide
echo $HR

echo "Check env-vars of the pod:"
echo "kubectl exec kiada-ssl -c envoy -n=chp09-set924b -- env"
echo ""
kubectl exec kiada-ssl -c envoy -n=chp09-set924b -- env
echo $HR

echo "Log into envoy container and check the contents of the /etc/envoy directory"
echo ""
echo "kubectl exec kiada-ssl -c envoy -n=chp09-set924b -- ls /etc/envoy"
kubectl exec kiada-ssl -c envoy -n=chp09-set924b -- ls /etc/envoy
echo $HR 

echo "kubectl delete ns chp09-set924b"
kubectl delete ns chp09-set924b

echo $HR_TOP