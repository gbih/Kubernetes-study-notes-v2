#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP


echo "In a separate terminal window, run:"
echo "kubectl get pods -w -n=chp05-set552"
enter

echo "kubectl apply -f $FULLPATH/set552_namespace.yaml"
kubectl apply -f $FULLPATH/set552_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set552_pod.yaml"
kubectl apply -f $FULLPATH/set552_pod.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-init -n=chp05-set552 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-init -n=chp05-set552 --timeout=120s
echo ""

echo "kubectl get all -n=chp05-set552 -o wide"
kubectl get all -n=chp05-set552 -o wide
echo $HR

echo "IP=\$(kubectl get pod pods/kiada-init -n=chp05-set552 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp05-set552 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR


echo "Accessing directly the node.js app (HTTP connection)"
echo "curl http://$IP:8080"
echo ""
curl http://$IP:8080

echo $HR 

echo "Accessing the node.js app via HTTPS connection with Envoy sidecar"
echo "curl https://$IP:8443 --insecure"
echo ""
curl https://$IP:8443 --insecure
enter


echo "Check Events"
echo "Event objects contain information about what happened to the object and what the source of the event was"
echo ""
echo "kubectl get events -n=chp05-set552"
echo ""
kubectl get events -n=chp05-set552
enter


echo "View logs of the kiada-init container:"
echo ""
echo "kubectl logs kiada-init -c kiada -n=chp05-set552"
echo ""
kubectl logs kiada-init -c kiada -n=chp05-set552
enter


echo "View logs of the envoy container:"
echo ""
echo "kubectl logs kiada-init -c envoy -n=chp05-set552"
echo ""
kubectl logs kiada-init -c envoy -n=chp05-set552
enter


echo "kubectl describe pod kiada-init -n=chp05-set552"
kubectl describe pod kiada-init -n=chp05-set552
echo $HR


echo "kubectl delete ns chp05-set552"
kubectl delete ns chp05-set552

echo $HR_TOP
