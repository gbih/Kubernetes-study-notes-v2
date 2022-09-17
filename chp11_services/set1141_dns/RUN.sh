#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1141_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1141 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1141 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""

kubectl apply -f $FULLPATH/set1141_svc_loadbalancer_kiada.yaml
kubectl apply -f $FULLPATH/set1141_svc_quote.yaml
kubectl apply -f $FULLPATH/set1141_svc_quiz.yaml
echo $HR 

echo "kubectl apply -f $FULLPATH/dns-test.yaml"
kubectl apply -f $FULLPATH/dns-test.yaml
echo ""
echo "kubectl wait --for=condition=Ready=True pods/dns-test -n=chp11-set1141 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/dns-test -n=chp11-set1141 --timeout=120s
enter

echo "kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup quote"
kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup quote
enter

echo "Use dig instead of nslookup:"
echo "kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup quote"
kubectl exec -it pods/dns-test -n chp11-set1141 -- dig +search quote
echo $HR 


echo "Look up SRV records:"
echo ""
echo "kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup -query=SRV kiada"
kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup -query=SRV kiada
echo $HR 

echo "Get the SRV records for the http port:"
echo ""
echo "kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup -query=SRV _http._tcp.kiada"
kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup -query=SRV _http._tcp.kiada
echo $HR 

enter_delete

echo "kubectl delete ns chp11-set1141"
kubectl delete ns chp11-set1141

echo $HR_TOP