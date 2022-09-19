#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1221_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1221 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1221 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

kubectl apply -f $FULLPATH/set1221_dns-test.yaml
echo ""

kubectl apply -f $FULLPATH/set1221_dns-test.yaml
kubectl apply -f $FULLPATH/set1221_ingress_kiada.yaml


echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1221 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1221 --timeout=120s
echo $HR 

enter

echo "kubectl get all -n=chp12-set1221"
kubectl get all -n=chp12-set1221
echo $HR 



echo "kubectl get ingresses -n=chp12-set1221"
echo ""
kubectl get ingresses -n=chp12-set1221
enter

echo "kubectl get ing kiada-example-com  -n=chp12-set1221 -o yaml"
kubectl get ing kiada-example-com  -n=chp12-set1221 -o yaml
enter

echo "kubectl describe ing kiada-example-com -n=chp12-set1221"
echo ""
kubectl describe ing kiada-example-com -n=chp12-set1221
enter


ingress_ip_kiada=$(kubectl get ing kiada-example-com -n=chp12-set1221 -o jsonpath={'.status.loadBalancer.ingress[0].ip'})
echo "Ingress IP of kiada: $ingress_ip_kiada"
echo $HR


# Only need to do this setup once
echo "sudo chmod a+wrx /etc/hosts"
# sudo chmod a+wrx /etc/hosts
echo $HR

echo "Add the ingress IP to the DNS (in the case of our microk8s cluster, the main node):"
echo ""
echo "sudo echo $ingress_ip_kiada kiada.example.com >> /etc/hosts"
# echo $ingress_ip_kiada kiada.example.com >> /etc/hosts
echo $HR

echo "cat /etc/hosts"
cat /etc/hosts

enter

# Another option for a local development cluster
echo "curl --resolve kiada.example.com:80:127.0.0.1 http://kiada.example.com -v"
curl --resolve kiada.example.com:80:127.0.0.1 http://kiada.example.com -v

enter_delete

echo "kubectl delete ns chp12-set1221"
kubectl delete ns chp12-set1221

echo $HR_TOP