#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set924_namespace.yaml
echo $HR 

echo "kubectl create configmap kiada-envoy-config -n=chp09-set924 --from-file=configmap-files"
kubectl create configmap kiada-envoy-config -n=chp09-set924 --from-file=configmap-files
echo $HR

echo "kubectl get cm kiada-envoy-config -n=chp09-set924"
kubectl get cm kiada-envoy-config -n=chp09-set924
echo $HR

kubectl apply -f $FULLPATH/set924_pod.yaml
echo $HR

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set924 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set924 --timeout=120s
echo $HR

echo "kubectl get pods/kiada-ssl -n=chp09-set924 -o wide"
kubectl get pods/kiada-ssl -n=chp09-set924 -o wide
echo $HR

echo "Check env-vars of the pod:"
echo "kubectl exec kiada-ssl -c envoy -n=chp09-set924 -- env"
echo ""
kubectl exec kiada-ssl -c envoy -n=chp09-set924 -- env
echo $HR

echo "Log into envoy container and check the contents of the /etc/envoy directory"
echo ""
echo "kubectl exec kiada-ssl -c envoy -n=chp09-set924 -- ls /etc/envoy"
kubectl exec kiada-ssl -c envoy -n=chp09-set924 -- ls /etc/envoy
echo $HR 

echo "kubectl delete ns chp09-set924"
kubectl delete ns chp09-set924

echo $HR_TOP