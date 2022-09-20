#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1224_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1224 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1224 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

kubectl apply -f $FULLPATH/set1224_dns-test.yaml
echo ""

kubectl apply -f $FULLPATH/set1224_fun_404.yaml
echo ""

kubectl apply -f $FULLPATH/set1224_ingress_default_backend.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1224 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1224 --timeout=120s
echo $HR 

enter

ingress_ip=$(kubectl get ing kiada -n=chp12-set1224 -o jsonpath={'.status.loadBalancer.ingress[0].ip'})

echo "Check our ingress rules and routes:"
echo ""
echo "kubectl describe ing kiada -n=chp12-set1224"
kubectl describe ing kiada -n=chp12-set1224
echo $HR

echo "Send a request that doesn't match any of the rules in the ingress"
echo ""
echo "curl api.example.com/unknown-path --resolve api.example.com:80:$ingress_ip"
echo ""
curl api.example.com/unknown-path --resolve api.example.com:80:$ingress_ip
echo "" 

enter_delete

echo "kubectl delete ns chp12-set1224"
kubectl delete ns chp12-set1224

echo $HR_TOP