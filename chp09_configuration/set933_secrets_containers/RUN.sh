#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set933_namespace.yaml
echo $HR 

echo "kubectl create configmap kiada-envoy-config -n=chp09-set933 --from-file=configmap-files"
kubectl create configmap kiada-envoy-config \
-n=chp09-set933 \
--from-file=configmap-files \
--dry-run=client -o yaml > set933_kiada-envoy-config.yaml
echo $HR

kubectl apply -f $FULLPATH/set933_kiada-envoy-config.yaml
echo $HR

echo "Create a TLS Secret, style 1"
kubectl create secret tls kiada-tls -n=chp09-set933 \
--cert secrets-files/example-com.crt \
--key secrets-files/example-com.key

echo $HR 

kubectl describe secret/kiada-tls -n=chp09-set933
echo $HR 

kubectl apply -f $FULLPATH/set933_pod.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set933 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set933 --timeout=120s
enter

echo "Log into envoy container and check the contents of the /etc/envoy directory"
echo ""
echo "kubectl exec kiada-ssl -c envoy -n=chp09-set933 -- cat /etc/certs/example-com.crt"
kubectl exec kiada-ssl -c envoy -n=chp09-set933 -- cat /etc/certs/example-com.crt
enter

echo "Check logs:"
kubectl logs kiada-ssl -n=chp09-set933
echo $HR 

echo "kubectl delete ns chp09-set933"
kubectl delete ns chp09-set933

echo $HR_TOP