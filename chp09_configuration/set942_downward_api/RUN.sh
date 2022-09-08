#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set942_namespace.yaml
echo $HR 

echo "kubectl create configmap kiada-envoy-config -n=chp09-set942 --from-file=configmap-files"
kubectl create configmap kiada-envoy-config \
-n=chp09-set942 \
--from-file=configmap-files \
--dry-run=client -o yaml > set942_kiada-envoy-config.yaml
echo $HR

kubectl apply -f $FULLPATH/set942_kiada-envoy-config.yaml
echo $HR

echo "Create a TLS Secret, style 1"
kubectl create secret tls kiada-tls -n=chp09-set942 \
--cert secrets-files/example-com.crt \
--key secrets-files/example-com.key

echo $HR 

kubectl describe secret/kiada-tls -n=chp09-set942
echo $HR 

kubectl apply -f $FULLPATH/set942_pod.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set942 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp09-set942 --timeout=120s
enter

echo "These env vars are passed from the pod by the Downward API:"
echo "POD_NAME, POD_IP, NODE_NAME, NODE_IP"
echo $HR

echo "IP=\$(kubectl get pods/kiada-ssl -n=chp09-set942 -o jsonpath='{.status.podIP}')"
IP=$(kubectl get pods/kiada-ssl -n=chp09-set942 -o jsonpath='{.status.podIP}')
echo $IP
echo $HR

echo "Accessing directly the node.js app (HTTP connection)"
echo "curl http://$IP:8080"
echo ""
curl http://$IP:8080

echo $HR 

echo "Log into kiada container and check the env var"
echo ""
echo "kubectl exec kiada-ssl -c kiada -n=chp09-set942 -- env"
kubectl exec kiada-ssl -c kiada -n=chp09-set942 -- env
enter

echo "Check logs:"
echo ""
kubectl logs kiada-ssl -n=chp09-set942
echo $HR 

echo "kubectl delete ns chp09-set942"
kubectl delete ns chp09-set942

echo $HR_TOP