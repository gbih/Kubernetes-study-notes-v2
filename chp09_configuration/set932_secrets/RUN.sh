#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set932_namespace.yaml
echo $HR 


echo "Create a TLS Secret, style 1"
kubectl create secret tls kiada-tls -n=chp09-set932 \
--cert secrets/example-com.crt \
--key secrets/example-com.key

echo $HR 

kubectl describe secret/kiada-tls -n=chp09-set932

enter

echo "Create a generic secret"
kubectl create secret generic kiada-tls-generic -n=chp09-set932 \
--from-file tls.crt=secrets/example-com.crt \
--from-file tls.key=secrets/example-com.key

echo $HR

kubectl describe secret/kiada-tls-generic -n=chp09-set932

enter

echo "Create a secret YAML manifest with user credentials with under keys user and pass."
echo "Assume user and pass are environmental variables, set up as:"
echo "user=...; export user"
echo "pass=...; export pass"
echo $HR 

kubectl create secret generic my-credentials \
--from-literal user=$user \
--from-literal pass=$pass \
--dry-run=client -o yaml

echo $HR


echo "kubectl delete ns chp09-set932"
kubectl delete ns chp09-set932

echo $HR_TOP