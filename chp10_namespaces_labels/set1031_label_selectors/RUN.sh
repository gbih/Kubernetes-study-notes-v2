#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Create namespace first"
kubectl apply -f $FULLPATH/set1031_namespace.yaml
echo $HR

echo "Next, create objects"
kubectl apply -f $FULLPATH/kiada --recursive
echo ""

kubectl apply -f $FULLPATH/quiz --recursive
echo ""

kubectl apply -f $FULLPATH/quote --recursive
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp10-set1031 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp10-set1031 --timeout=120s
echo $HR 

enter

echo "Label some pods manually"
echo ""

echo "kubectl label pod quote-canary app=quote --overwrite -n=chp10-set1031"
kubectl label pod quote-canary app=quote --overwrite -n=chp10-set1031
echo ""

echo "kubectl label pod kiada-canary app=kiada rel=canary --overwrite -n=chp10-set1031"
kubectl label pod kiada-canary app=kiada rel=canary  --overwrite -n=chp10-set1031
echo ""

echo "kubectl label pod quote-canary app=kiada rel=canary  --overwrite -n=chp10-set1031"
kubectl label pod quote-canary app=kiada rel=canary  --overwrite -n=chp10-set1031
echo $HR 

echo "1. Using Label selectors:"
echo ""

echo "kubectl get pods -l app=quote --show-labels -n=chp10-set1031 | head"
kubectl get pods -l app=quote --show-labels -n=chp10-set1031 | head
echo $HR

echo "kubectl get pods -l rel=canary --show-labels -n=chp10-set1031 | head"
kubectl get pods -l rel=canary --show-labels -n=chp10-set1031 | head
echo $HR


echo "2. Using Set-based selectors:"
echo ""

echo "kubectl get pods -l 'app in (quiz, quote)' -L app -n=chp10-set1031"
kubectl get pods -l 'app in (quiz, quote)' -L app -n=chp10-set1031
enter

echo "Remove the rel label from the quiz pod"
echo "kubectl label pod quiz rel- -n=chp10-set1031"
kubectl label pod quiz rel- -n=chp10-set1031
echo $HR

echo "Test for the presence or absense of a particular label key."
echo "kubectl get pods -l '!rel' --show-labels -n=chp10-set1031"
kubectl get pods -l '!rel' --show-labels -n=chp10-set1031
echo $HR 

echo "List all pods that have the rel label"
echo "kubectl get pods -l rel -L rel -n=chp10-set1031"
kubectl get pods -l rel -L rel -n=chp10-set1031
echo $HR 

echo "List nodes of a particular type"
echo "kubectl get nodes -l kubernetes.io/hostname -L kubernetes.io/hostname"
kubectl get nodes -l kubernetes.io/hostname -L kubernetes.io/hostname
enter

echo "Using labels to delete pods"
kubectl delete pods -l rel=canary -n=chp10-set1031
echo "kubectl delete pods -l rel=canary -n=chp10-set1031"
echo $HR 


echo "kubectl delete ns chp10-set1031"
kubectl delete ns chp10-set1031

echo $HR_TOP