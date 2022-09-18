#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1143_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1143 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1143 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""

kubectl apply -f $FULLPATH/set1143_svc_loadbalancer_kiada.yaml
kubectl apply -f $FULLPATH/set1143_svc_quote.yaml
kubectl apply -f $FULLPATH/set1143_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1143_svc_headless_quote.yaml
kubectl apply -f $FULLPATH/set1143_svc_external_name.yaml
kubectl apply -f $FULLPATH/dns-test.yaml
echo $HR 

echo ""
echo "kubectl wait --for=condition=Ready=True pods/dns-test -n=chp11-set1143 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/dns-test -n=chp11-set1143 --timeout=120s
enter

echo "Connect to an ExternalName service from a pod."
echo ""
echo 'kubectl exec -it pods/kiada-001 -c kiada -n chp11-set1143 -- bash -c "curl http://time-api/api/timezone/CET" | jq'
kubectl exec -it pods/kiada-001 -c kiada -n chp11-set1143 -- bash -c "curl http://time-api/api/timezone/CET" | jq
enter

echo "Resolving ExternalName services in DNS"
echo ""
echo -e \
	"Because ExternalName services are implemented at the DNS level," \
	"clients don't connect to the service through the cluster IP." \
	"They connect directly to the external service." \
	"Like headless services, ExternalName services have no cluster IP."
echo ""
echo "kubectl get svc time-api -n=chp11-set1143"
echo ""
kubectl get svc time-api -n=chp11-set1143
echo $HR
 
echo "Resolve the time-api service in the dns-test pod."
echo "We should be able to see that time-api.kiada.svc.cluster.local points to worldtimeapi.org:"
echo ""
echo "kubectl exec -it pod/dns-test -n chp11-set1143 -- nslookup time-api"
echo ""
kubectl exec -it pod/dns-test -n chp11-set1143 -- nslookup time-api

enter_delete

echo "kubectl delete ns chp11-set1143"
kubectl delete ns chp11-set1143

echo $HR_TOP