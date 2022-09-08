#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set951_namespace.yaml
echo $HR 


echo """kubectl create configmap kiada-envoy-config \
-n=chp09-set951 \
--from-file=configmap-files \
--dry-run=client -o yaml > set951_kiada-envoy-config.yaml"""

kubectl create configmap kiada-envoy-config \
-n=chp09-set951 \
--from-file=configmap-files \
--dry-run=client -o yaml > set951_kiada-envoy-config.yaml
echo ""


kubectl apply -f $FULLPATH/set951_kiada-envoy-config.yaml
echo $HR

echo "Create a TLS Secret, style 1"
kubectl create secret tls kiada-tls -n=chp09-set951 \
--cert secrets-files/example-com.crt \
--key secrets-files/example-com.key

echo $HR 

echo "kubectl describe secret/kiada-tls -n=chp09-set951"
echo ""
kubectl describe secret/kiada-tls -n=chp09-set951
echo $HR 

kubectl apply -f $FULLPATH/set951_pod.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set951 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set951 --timeout=120s
enter

echo "Log into kiada container and check the pod-metadata directory"
echo ""
echo "kubectl exec kiada-ssl -c envoy -n=chp09-set951 -- ls /etc/envoy"
kubectl exec kiada-ssl -c envoy -n=chp09-set951 -- ls /etc/envoy
echo $HR 


echo "kubectl delete ns chp09-set951"
kubectl delete ns chp09-set951

echo $HR_TOP