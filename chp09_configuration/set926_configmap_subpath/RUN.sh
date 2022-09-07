#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set926_namespace.yaml
echo $HR 

echo "kubectl create configmap kiada-envoy-config -n=chp09-set926 --from-file=configmap-files"
kubectl create configmap kiada-envoy-config -n=chp09-set926 --from-file=configmap-files
echo $HR

echo "kubectl get cm kiada-envoy-config -n=chp09-set926"
kubectl get cm kiada-envoy-config -n=chp09-set926
echo $HR

kubectl apply -f $FULLPATH/set926_pod.yaml
echo $HR

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set926 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set926 --timeout=120s
echo $HR

echo "Log into envoy container and check the contents of the /etc/envoy directory"
echo ""
echo "kubectl exec kiada-ssl -c envoy -n=chp09-set926 -- ls -lA /etc"
kubectl exec kiada-ssl -c envoy -n=chp09-set926 -- ls -lA /etc
echo $HR 

echo "kubectl delete ns chp09-set926"
kubectl delete ns chp09-set926

echo $HR_TOP