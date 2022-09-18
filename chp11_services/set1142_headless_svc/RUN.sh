#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1142_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1142 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1142 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""

kubectl apply -f $FULLPATH/set1142_svc_loadbalancer_kiada.yaml
kubectl apply -f $FULLPATH/set1142_svc_quote.yaml
kubectl apply -f $FULLPATH/set1142_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1142_svc_headless_quote.yaml
echo $HR 

echo "kubectl apply -f $FULLPATH/dns-test.yaml"
kubectl apply -f $FULLPATH/dns-test.yaml
echo ""
echo "kubectl wait --for=condition=Ready=True pods/dns-test -n=chp11-set1142 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/dns-test -n=chp11-set1142 --timeout=120s
enter

echo "We can see that our headless service has no cluster IP:"
echo ""
echo "kubectl get svc quote-headless -n chp11-set1142 -o wide"
kubectl get svc quote-headless -n chp11-set1142 -o wide
echo $HR

echo "Our headless service will directly use the IP addresses of the pods:"
echo ""
echo "kubectl get pods -n chp11-set1142 -l app=quote -o wide | sort"
kubectl get pods -n chp11-set1142 -l app=quote -o wide | sort
enter

echo "Look up A-Record for the headless service."
echo "Here, the DNS server returns the IP addresses of the four pods that match the service's label selector."
echo ""
echo "kubectl exec -it pods/dns-test -n chp11-set1142 -- nslookup quote-headless"
kubectl exec -it pods/dns-test -n chp11-set1142 -- nslookup quote-headless
enter

echo "Compare to the A-Record for a regular non-headless service"
echo "Now, the returned name resolves to the cluster IP of the service:"
echo ""
echo "kubectl exec -it pods/dns-test -n chp11-set1142 -- nslookup quote"
kubectl exec -it pods/dns-test -n chp11-set1142 -- nslookup quote
enter

echo "Understand how clients use headless services"
echo ""
echo "Send multiple requests the quote-headless service with curl from the dns-test pod."
echo "Each request is handled by a different pod, just like when you use the regular service."
echo "With a headless service, you connect directly to the pod IP"
echo ""

# Use dns-test image that has bash so we can conveniently use a for-loop
echo 'kubectl exec -it pods/dns-test -n chp11-set1142 -- bash -c "for i in {1..7}; do curl http://quote-headless; sleep 0.5; done"'
echo ""
kubectl exec -it pods/dns-test -n chp11-set1142 -- bash -c "for i in {1..7}; do curl http://quote-headless; sleep 0.5; done"
enter_delete

echo "kubectl delete ns chp11-set1142"
kubectl delete ns chp11-set1142

echo $HR_TOP