#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

echo "Creating a service with kubectl"

echo "kubectl create namespace chp03-set332"
kubectl create namespace chp03-set332
echo $HR

echo "kubectl create deployment kiada --image=georgebaptista/kiada:0.1 -n=chp03-set332"
kubectl create deployment kiada --image=georgebaptista/kiada:0.1 -n=chp03-set332
echo $HR

echo "kubectl rollout status deployment kiada -n=chp03-set332"
kubectl rollout status deployment kiada -n=chp03-set332
echo $HR

echo "kubectl wait --for=condition=available --timeout=60s --all deployments -n=chp03-set332"
kubectl wait --for=condition=available --timeout=60s --all deployments -n=chp03-set332
echo $HR

enter

echo "Create service for ki"
echo "kubectl expose deployment kiada --type=LoadBalancer --port 8080 -n=chp03-set332"
kubectl expose deployment kiada --type=LoadBalancer --port 8080  -n=chp03-set332
echo $HR


echo "kubectl get all -n=chp03-set332"
kubectl get all -n=chp03-set332
enter


echo "kubectl get svc kiada -n=chp03-set332 -o" json
kubectl get svc kiada -n=chp03-set332 -o json
enter


echo "EXTERNAL_IP=\$(kubectl get svc kiada -n=chp03-set332 -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" 
EXTERNAL_IP=$(kubectl get svc kiada -n=chp03-set332 -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $EXTERNAL_IP
echo $HR

echo "curl http://$EXTERNAL_IP:8080"
curl http://$EXTERNAL_IP:8080
curl http://$EXTERNAL_IP:8080
curl http://$EXTERNAL_IP:8080
echo $HR


echo "Clean up namespace and deployment"
kubectl delete namespace chp03-set332


echo $HR_TOP