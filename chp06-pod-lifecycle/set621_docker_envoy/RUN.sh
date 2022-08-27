#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

# If necessary, make sure these ports are free:
# fuser 8080/tcp -k
# fuser 8443/tcp -k
# fuser 9901/tcp -k


echo "kubectl apply -f $FULLPATH/set621_namespace.yaml"
kubectl apply -f $FULLPATH/set621_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set621_pod.yaml"
kubectl apply -f $FULLPATH/set621_pod.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp06-set621 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-ssl -n=chp06-set621 --timeout=120s
echo ""

echo "kubectl get all -n=chp06-set621 -o wide"
kubectl get all -n=chp06-set621 -o wide
echo $HR

echo "IP=\$(kubectl get pod -n=chp06-set621 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp06-set621 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR

echo "In another terminal, monitor the pod status via:"
echo "kubectl get pods -n=chp06-set621 -w"
echo $HR

echo "Use Envoy administration interface to stop the process via its HTTP API."
echo "curl -X POST $IP:9901/quitquitquit"
echo "Press <ENTER> to start the crash"
enter_no_clear
curl -X POST $IP:9901/quitquitquit
echo $HR

echo "Press <ENTER> to end script and delete components"
enter

echo "kubectl delete ns chp06-set621"
kubectl delete ns chp06-set621

echo $HR_TOP