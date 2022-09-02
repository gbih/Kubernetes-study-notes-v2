#!/bin/bash
source ../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/cluster-test_namespace.yaml"
kubectl apply -f $FULLPATH/cluster-test-namespace.yaml
echo $HR

echo "kubectl create deployment hello-node -n=cluster-test --image=k8s.gcr.io/echoserver:1.4"
kubectl create deployment hello-node -n=cluster-test --image=k8s.gcr.io/echoserver:1.4
echo $HR

echo "kubectl rollout status deployment/hello-node -n=cluster-test"
kubectl rollout status deployment/hello-node -n=cluster-test
echo $HR

echo "kubectl get deployments -n=cluster-test"
kubectl get deployments -n=cluster-test
echo $HR

echo "kubectl get all -n=cluster-test -o wide"
kubectl get all -n=cluster-test -o wide
echo $HR

echo "kubectl scale deployments/hello-node -n=cluster-test --replicas=10"
kubectl scale deployments/hello-node -n=cluster-test --replicas=10
echo $HR

echo "kubectl rollout status deployment/hello-node -n=cluster-test"
kubectl rollout status deployment/hello-node -n=cluster-test
echo $HR

echo "kubectl get all -n=cluster-test -o wide"
kubectl get all -n=cluster-test -o wide
echo $HR

echo "IP=\$(kubectl get pod -n=cluster-test -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=cluster-test -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR

echo "kubectl delete ns cluster-test"
kubectl delete ns cluster-test

echo $HR_TOP