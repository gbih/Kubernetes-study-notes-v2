#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

##### Set-up

echo $HR_TOP

kubectl apply -f $FULLPATH/set1241_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1241 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1241 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

kubectl apply -f $FULLPATH/set1241_dns-test.yaml
kubectl apply -f $FULLPATH/set1241_fun_404.yaml
kubectl apply -f $FULLPATH/set1241_ingress_annotations.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1241 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1241 --timeout=120s
echo $HR 

enter

##### Main tasks

echo "Use annotations to configure session affinity in an Nginx ingress."
echo ""


echo "Check our Ingress rules and routes:"
echo ""
echo "kubectl describe ing kiada -n=chp12-set1241"
kubectl describe ing kiada -n=chp12-set1241
enter

ingress_ip=$(kubectl get ing kiada -n=chp12-set1241 -o jsonpath={'.status.loadBalancer.ingress[0].ip'})


# Original response to "curl --silent -I http://kiada.example.com --resolve kiada.example.com:80:127.0.0.1"

# HTTP/1.1 200 OK
# Date: Tue, 20 Sep 2022 08:12:10 GMT
# Content-Type: text/plain
# Connection: keep-alive
# Set-Cookie: SESSION_COOKIE=1663661531.322.715.719150|f4cd5cb3890a8745725b6cd978e1ff48; Path=/; HttpOnly

# We want to filter out SESSION_COOKIE=1663661531.322.715.719150|f4cd5cb3890a8745725b6cd978e1ff48'
# Ugly but workable..

echo "Retrieve the session cookie from Nginx, then clean up:"
echo ""
# -I option for curl: show document info only
resp1=$(curl --silent -I http://kiada.example.com --resolve kiada.example.com:80:127.0.0.1); echo $resp1
resp2=$(echo $resp1 | cut -d ';' -f 1 | xargs); echo $resp2
resp3=$(echo $resp2 | awk -F 'Set-Cookie:' '{print $2}'); echo $resp3
echo $HR 

echo "Include session cookie in request. The HTTP request should always be forwarded to the same pod, indicating session affinity is using the cookie."
echo ""
for i in {1..10} 
do
	curl -s -H "Cookie: $resp3" http://kiada.example.com --resolve kiada.example.com:80:127.0.0.1 | grep "Request processed"
done

echo $HR 

echo "Do not include session cookie in request. This should result in the ingress doing load-balancing among the different pods."
echo ""
for i in {1..10} 
do
	curl -s http://kiada.example.com --resolve kiada.example.com:80:127.0.0.1 | grep "Request processed"
done

enter_delete

##### Clean-up

echo "kubectl delete ns chp12-set1241"
kubectl delete ns chp12-set1241

echo $HR_TOP