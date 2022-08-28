#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set626_namespace.yaml"
kubectl apply -f $FULLPATH/set626_namespace.yaml
echo $HR

echo "In a separate terminal, run this"
echo "kubectl get events -w -n=chp06-set626"

enter_no_clear

echo "kubectl apply -f $FULLPATH/set626_pod.yaml"
kubectl apply -f $FULLPATH/set626_pod.yaml
echo $HR

echo "kubectl wait --for=condition=Ready=True pod kiada-liveness -n=chp06-set626 --timeout=120s"
kubectl wait --for=condition=Ready=True pod kiada-liveness -n=chp06-set626 --timeout=120s
echo ""

echo "The only indication that Kubernetes is executing the probe is found in the container logs."

echo $HR
echo "kubectl logs kiada-liveness -c kiada  -n=chp06-set626"
echo ""
kubectl logs kiada-liveness -c kiada -n=chp06-set626
enter

echo "kubectl exec kiada-liveness -n=chp06-set626 -c envoy -- tail /tmp/envoy.admin.log"
echo ""
kubectl exec kiada-liveness -n=chp06-set626 -c envoy -- tail /tmp/envoy.admin.log
enter


echo "kubectl get all -n=chp06-set626 -o wide"
kubectl get all -n=chp06-set626 -o wide
echo $HR

echo "IP=\$(kubectl get pod -n=chp06-set626 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp06-set626 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR


echo "Make the healthness test fail"
echo "curl -X POST $IP:9901/healthcheck/fail"
echo "Press <ENTER> to start the crash"
enter_no_clear
echo "curl -X POST $IP:9901/healthcheck/fail"
curl -X POST $IP:9901/healthcheck/fail
echo "curl -X POST $IP:9901/healthcheck/fail"
curl -X POST $IP:9901/healthcheck/fail
echo "curl -X POST $IP:9901/healthcheck/fail"
curl -X POST $IP:9901/healthcheck/fail
echo "curl -X POST $IP:9901/healthcheck/fail"
curl -X POST $IP:9901/healthcheck/fail
echo "curl -X POST $IP:9901/healthcheck/fail"
curl -X POST $IP:9901/healthcheck/fail

enter_no_clear


echo "Make the liveness probe succeed again"
echo "curl -X POST $IP:9901/healthcheck/ok"
curl -X POST $IP:9901/healthcheck/ok
echo $HR

echo "kubectl wait --for=condition=Ready=True pod liveness -n=chp06-set626 --timeout=120s"
kubectl wait --for=condition=Ready=True pod kiada-liveness -n=chp06-set626 --timeout=120s
echo ""


echo "kubectl get pod kiada-liveness -n=chp06-set626"
kubectl get pod kiada-liveness -n=chp06-set626
enter 


echo "kubectl describe pod kiada-liveness -n=chp06-set626"
kubectl describe pod kiada-liveness -n=chp06-set626
echo $HR


echo "kubectl delete ns chp06-set626"
kubectl delete ns chp06-set626

echo $HR_TOP