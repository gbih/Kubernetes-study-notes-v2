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

echo "Look up a Service's A-Record."
echo "An A record maps a domain name to the IP address of the computer hosting the domain. An A record uses a domain name to find the IP address of a computer connected to the internet."
echo ""
echo "kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup quote"
echo ""
kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup quote

enter

echo "Use dig instead of nslookup to look up a Service's A-Record"
echo ""
echo "kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup quote"
kubectl exec -it pods/dns-test -n chp11-set1141 -- dig +search quote

enter

echo "Look up SRV records for the kiada service."
echo ""
echo "SRV records help with service discovery. An SRV record typically defines a symbolic name and the transport protocol used as part of the domain name. It defines the priority, weight, port, and target for the service in the record content."
echo ""
echo "SRV record format: _port-name._port-protocol.service-name.namespace.svc.cluster.local"
echo ""
echo "kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup -query=SRV kiada"
echo ""
kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup -query=SRV kiada

enter

echo "Get the SRV records for the kiada http port."
echo ""
echo "Since we defined the names for these ports in the Service object, they can be looked up by name."
echo ""
echo "SRV record format: _port-name._port-protocol.service-name.namespace.svc.cluster.local"
echo ""
echo "kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup -query=SRV _http._tcp.kiada"
echo ""
kubectl exec -it pods/dns-test -n chp11-set1141 -- nslookup -query=SRV _http._tcp.kiada
echo $HR 

enter_delete

echo "kubectl delete ns chp11-set1141"
kubectl delete ns chp11-set1141

echo $HR_TOP