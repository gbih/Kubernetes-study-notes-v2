#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

echo "Creating a service with kubectl"

echo "kubectl create namespace chp03-set333"
kubectl create namespace chp03-set333
echo $HR

echo "kubectl create deployment kiada --image=georgebaptista/kiada:0.1 -n=chp03-set333"
kubectl create deployment kiada --image=georgebaptista/kiada:0.1 -n=chp03-set333
echo $HR

echo "kubectl rollout status deployment kiada -n=chp03-set333"
kubectl rollout status deployment kiada -n=chp03-set333
echo $HR


echo "Wait for the new deployment to be created and have available-status."
echo "kubectl wait --for=condition=available --timeout=60s --all deployments -n=chp03-set333"
kubectl wait --for=condition=available --timeout=60s --all deployments -n=chp03-set333
echo $HR

echo "kubectl get all -n=chp03-set333"
kubectl get all -n=chp03-set333
enter


echo "Expose this deployment:"
echo ""

echo "kubectl expose deployment kiada --type=LoadBalancer --port 8080 -n=chp03-set333"
kubectl expose deployment kiada --type=LoadBalancer --port 8080  -n=chp03-set333
echo $HR

echo "kubectl scale deployment kiada --replicas=3 -n=chp03-set333"
kubectl scale deployment kiada --replicas=3 -n=chp03-set333
echo $HR

echo "Wait for the new pods to be created and have ready-status. -l is the label option:"
echo "kubectl wait --for=condition=ready  --timeout=60s pod -l app=kiada -n=chp03-set333"
kubectl wait --for=condition=ready  --timeout=60s pod -l app=kiada -n=chp03-set333
echo $HR

echo "kubectl get all -n=chp03-set333"
kubectl get all -n=chp03-set333
enter


echo "Clean up namespace and deployment"
kubectl delete namespace chp03-set333

echo $HR_TOP