#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Since we are using multiple notes, try using openebs-hostpath as the default Storage Class"
echo "Explore changing the default StorageClass on microk8s"
echo $HR 

echo "1. List the StorageClasses in your cluster:"
echo ""
echo "kubectl get sc"
kubectl get sc
echo ""

echo $HR 


echo "2. Mark the default StorageClass as non-default:"
echo ""
echo 'kubectl patch sc microk8s-hostpath -p {"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
kubectl patch sc microk8s-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
echo ""
echo "kubectl get sc"
kubectl get sc

echo $HR 


echo "3. Mark a StorageClass as default:"
echo ""
echo 'kubectl patch storageclass openebs-hostpath -p {"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl patch storageclass openebs-hostpath -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
echo ""
echo "kubectl get sc"
kubectl get sc

echo $HR 


# echo "kubectl get sc openebs-hostpath -o yaml"
# kubectl get sc openebs-hostpath -o yaml






enter

echo "Create namespace first"
kubectl apply -f $FULLPATH/set1113b_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1113b --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1113b --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""


kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1113b --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1113b --timeout=120s

echo $HR 

kubectl apply -f $FULLPATH/set1113b_svc_quote.yaml
kubectl apply -f $FULLPATH/set1113b_svc_quiz.yaml

echo $HR 

echo "kubectl get pods -n=chp11-set1113b --show-labels | sort"
kubectl get pods -n=chp11-set1113b --show-labels | sort
echo $HR 

echo "kubectl get svc -n=chp11-set1113b -o wide"
kubectl get svc -n=chp11-set1113b -o wide
echo $HR



echo "kubectl port-forward kiada-001 -n=chp11-set1113b 8080 8443"
kubectl port-forward kiada-001 -n=chp11-set1113b 8080 8443


# echo "QUIZ_CLUSTER_IP=$(kubectl get svc/quiz -n=chp11-set1113b -o=jsonpath={'.spec.clusterIP'})"
# QUIZ_CLUSTER_IP=$(kubectl get svc/quiz -n=chp11-set1113b -o=jsonpath={'.spec.clusterIP'})

# echo "QUOTE_CLUSTER_IP=$(kubectl get svc/quote -n=chp11-set1113b -o=jsonpath={'.spec.clusterIP'})"
# QUOTE_CLUSTER_IP=$(kubectl get svc/quote -n=chp11-set1113b -o=jsonpath={'.spec.clusterIP'})



# echo "The quote service acts as a load balancer. It distributes requests to all the pods that are behind it."
# echo ""
# for i in {1..5}
# do
# 	kubectl exec quote-001 -n=chp11-set1113b -c nginx -- curl -s $QUOTE_CLUSTER_IP 
# done

# echo $HR


# enter



# echo "Check DNS settings in /etc/resolv.conf of pod quote-001:"
# echo "kubectl exec -n=chp11-set1113b -it quote-001 -c nginx -- sh -c 'cat /etc/resolv.conf'"
# echo ""
# kubectl exec -n=chp11-set1113b -it quote-001 -c nginx -- sh -c 'cat /etc/resolv.conf'
# echo $HR 


# echo "We can thus use the service name, instead of its cluster IP"
# echo ""

# echo "This is using the shortest DNS name, <service-name>, which is 'quote'"
# echo "kubectl exec quote-001 -n=chp11-set1113b -c nginx -- curl -s quote"
# echo ""
# kubectl exec quote-001 -n=chp11-set1113b -c nginx -- curl -s quote
# echo $HR

# echo "The longest service name is <service-name>.<service-namespace>.svc.cluster.local, which is 'quote.chp11-set1113b.svc.cluster.local'"
# echo "kubectl exec quote-001 -n=chp11-set1113b -c nginx -- curl -s quote.chp11-set1113b.svc.cluster.local"
# echo ""
# kubectl exec quote-001 -n=chp11-set1113b -c nginx -- curl -s quote.chp11-set1113b.svc.cluster.local

# enter

# echo "Discovering services through env vars."

# echo "kubectl exec quote-001 -n=chp11-set1113b -c nginx -- kill 1"
# kubectl exec quote-001 -n=chp11-set1113b -c nginx -- kill 1
# echo $HR 

# echo "kubectl wait --for=condition=Ready=True pods/quote-001 -n=chp11-set1113b --timeout=120s"
# kubectl wait --for=condition=Ready=True pods/quote-001 -n=chp11-set1113b --timeout=120s
# echo $HR

# echo "kubectl exec -it quote-001 -n=chp11-set1113b -c nginx -- env | sort"
# kubectl exec -it quote-001 -n=chp11-set1113b -c nginx -- env | sort
# echo $HR 



# echo "Press [ENTER] to delete"
# enter

# echo "kubectl delete ns chp11-set1113b"
# kubectl delete ns chp11-set1113b

echo $HR_TOP