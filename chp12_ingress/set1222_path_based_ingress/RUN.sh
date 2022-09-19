#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1222_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1222 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1222 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

kubectl apply -f $FULLPATH/set1222_dns-test.yaml
echo ""

kubectl apply -f $FULLPATH/set1222_dns-test.yaml
kubectl apply -f $FULLPATH/set1222_ingress_kiada.yaml
kubectl apply -f $FULLPATH/set1222_ingress_quote.yaml

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1222 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1222 --timeout=120s
echo $HR 

enter

echo "kubectl get all -n=chp12-set1222"
kubectl get all -n=chp12-set1222
echo $HR 

echo "kubectl get ingresses -n=chp12-set1222"
echo ""
kubectl get ingresses -n=chp12-set1222
enter

api_example_ip_quote=$(kubectl get ing api-example-com -n=chp12-set1222 -o jsonpath={'.status.loadBalancer.ingress[0].ip'})
echo "Ingress IP of api-example: $api_example_ip_quote"
echo $HR

# Only need to do this setup once
# echo "sudo chmod a+wrx /etc/hosts"
# sudo chmod a+wrx /etc/hosts
# echo $HR

# echo "Add the ingress IP to the DNS (in the case of our microk8s cluster, the main node):"
# echo ""
# echo "sudo echo $api_example_ip_quote api.example.com >> /etc/hosts"
# echo $api_example_ip_quote api.example.com >> /etc/hosts
# echo $HR

echo "cat /etc/hosts"
cat /etc/hosts

enter

# Another option for a local development cluster
echo "curl --resolve api.example.com:80:127.0.0.1 http://api.example.com/quote"
echo ""
curl --resolve api.example.com:80:127.0.0.1 http://api.example.com/quote
enter

echo "curl --resolve api.example.com:80:127.0.0.1 http://api.example.com/questions/random"
echo ""
curl --resolve api.example.com:80:127.0.0.1 http://api.example.com/questions/random

enter_delete

echo "kubectl delete ns chp12-set1222"
kubectl delete ns chp12-set1222

echo $HR_TOP