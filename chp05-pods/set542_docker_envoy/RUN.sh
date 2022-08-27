#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set542_namespace.yaml"
kubectl apply -f $FULLPATH/set542_namespace.yaml
echo $HR

# echo "kubectl apply -f $FULLPATH/pod.kiada-ssl.yaml"
# kubectl apply -f $FULLPATH/pod.kiada-ssl.yaml

echo "kubectl apply -f $FULLPATH/set542_pod.yaml"
kubectl apply -f $FULLPATH/set542_pod.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp05-set542 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp05-set542 --timeout=120s
echo ""

echo "kubectl get all -n=chp05-set542 -o wide"
kubectl get all -n=chp05-set542 -o wide
echo $HR

echo "IP=\$(kubectl get pod -n=chp05-set542 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp05-set542 -o jsonpath='{.items[0].status.podIP}')
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


echo "View logs of the kiada-ssl container:"
echo ""
echo "kubectl logs kiada-ssl -c kiada -n=chp05-set542"
echo ""
kubectl logs kiada-ssl -c kiada -n=chp05-set542
enter


echo "View logs of the envoy container:"
echo ""
echo "kubectl logs kiada-ssl -c envoy -n=chp05-set542"
echo ""
kubectl logs kiada-ssl -c envoy -n=chp05-set542
enter


echo "kubectl describe pod kiada-ssl -n=chp05-set542"
kubectl describe pod kiada-ssl -n=chp05-set542
echo $HR


echo "kubectl delete ns chp05-set542"
kubectl delete ns chp05-set542

echo $HR_TOP
