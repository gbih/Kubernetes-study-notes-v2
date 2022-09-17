#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1113_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1113 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1113 --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp11-set1113 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp11-set1113 --timeout=120s

echo $HR 

kubectl apply -f $FULLPATH/set1113_svc_quote.yaml
kubectl apply -f $FULLPATH/set1113_svc_quote_session_affinity.yaml
kubectl apply -f $FULLPATH/set1113_svc_quiz.yaml

echo $HR 

echo "kubectl get pods -n=chp11-set1113 --show-labels | sort"
kubectl get pods -n=chp11-set1113 --show-labels | sort
echo $HR 

echo "kubectl get svc -n=chp11-set1113 -o wide"
kubectl get svc -n=chp11-set1113 -o wide
echo $HR 

echo "kubectl get pv"
kubectl get pv

enter

echo "QUIZ_CLUSTER_IP=$(kubectl get svc/quiz --no-headers -n=chp11-set1113 -o custom-columns=":spec.clusterIP")"
QUIZ_CLUSTER_IP=$(kubectl get svc/quiz --no-headers -n=chp11-set1113 -o custom-columns=":spec.clusterIP")

echo "QUOTE_CLUSTER_IP=$(kubectl get svc/quote --no-headers -n=chp11-set1113 -o custom-columns=":spec.clusterIP")"
QUOTE_CLUSTER_IP=$(kubectl get svc/quote --no-headers -n=chp11-set1113 -o custom-columns=":spec.clusterIP")

echo "QUOTE_SESSION_CLUSTER_IP=$(kubectl get svc/quote-session-affinity --no-headers -n=chp11-set1113 -o custom-columns=":spec.clusterIP")"
QUOTE_SESSION_CLUSTER_IP=$(kubectl get svc/quote-session-affinity --no-headers -n=chp11-set1113 -o custom-columns=":spec.clusterIP")
echo $HR 

echo "The quote service acts as a load balancer. It distributes requests to all the pods that are behind it."
echo "kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s $QUOTE_CLUSTER_IP"
echo ""
for i in {1..5}
do
	kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s $QUOTE_CLUSTER_IP 
done

echo $HR

echo "However, if we set spec.sessionAffinity to ClientIP, all connections originating from the same IP will be forwarded to the same pod. The default value of the session length is 3 hours."
echo "kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s $QUOTE_SESSION_CLUSTER_IP"
echo ""
for i in {1..5}
do
	kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s $QUOTE_SESSION_CLUSTER_IP 
done
echo $HR 

enter

echo "Check DNS settings in /etc/resolv.conf of pod quote-001:"
echo "kubectl exec -n=chp11-set1113 -it quote-001 -c nginx -- sh -c 'cat /etc/resolv.conf'"
echo ""
kubectl exec -n=chp11-set1113 -it quote-001 -c nginx -- sh -c 'cat /etc/resolv.conf'

echo $HR

echo "We can confirm that the IP address in the 'nameserver' line above refers to the kube-dns service:"
echo "kubectl get svc/kube-dns -n=kube-system"
kubectl get svc/kube-dns -n=kube-system

enter

echo "K8s clusters run an internal DNS server that all pods in the cluster are configured to use."
echo "This allows pods to resolve the cluster IP address of a service by name."
echo "So, using the cluster DNS, pods can connect to the quote service as in these examples:"
echo ""

echo "Form 1: http://<service-name>"
echo "kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s http://quote"
kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s http://quote
echo ""

echo "Form 2: http://<service-name>.<service-namespace>"
echo "kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s quote.chp11-set1113"
kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s quote.chp11-set1113
echo ""

echo "Form 3: http://<service-name>.<service-namespace>.svc"
echo "kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s quote.chp11-set1113.svc"
kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s quote.chp11-set1113.svc
echo ""

echo "Form 4: http://<service-name>.<service-namespace>.svc.cluster.local"
echo "kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s quote.chp11-set1113.svc.cluster.local"
kubectl exec quote-001 -n=chp11-set1113 -c nginx -- curl -s quote.chp11-set1113.svc.cluster.local


echo $HR 

enter

echo "Discovering services through env vars."

echo "kubectl exec quote-001 -n=chp11-set1113 -c nginx -- kill 1"
kubectl exec quote-001 -n=chp11-set1113 -c nginx -- kill 1
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quote-001 -n=chp11-set1113 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quote-001 -n=chp11-set1113 --timeout=120s
echo $HR

sleep 3

echo "kubectl exec -it quote-001 -n=chp11-set1113 -c nginx -- env | sort"
kubectl exec -it quote-001 -n=chp11-set1113 -c nginx -- env | sort

enter_delete

echo "kubectl delete ns chp11-set1113"
kubectl delete ns chp11-set1113

echo $HR_TOP