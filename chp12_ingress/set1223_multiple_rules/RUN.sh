#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1223_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1223 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1223 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

kubectl apply -f $FULLPATH/set1223_dns-test.yaml
echo ""

kubectl apply -f $FULLPATH/set1223_ingress_multiple_services.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1223 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1223 --timeout=120s
echo $HR 

enter

echo "kubectl get all -n=chp12-set1223"
kubectl get all -n=chp12-set1223
echo $HR 

echo "kubectl get ing kiada -n=chp12-set1223"
echo ""
kubectl get ing kiada -n=chp12-set1223
enter

ingress_ip=$(kubectl get ing kiada -n=chp12-set1223 -o jsonpath={'.status.loadBalancer.ingress[0].ip'})
echo "Ingress IP of api-example: $ingress_ip"

echo $HR

echo "cat /etc/hosts"
cat /etc/hosts

echo $HR

write_to_hosts () {
	HOST=$1
	INGRESS_IP=$2
	echo "sudo chmod a+wrx /etc/hosts"
	sudo chmod a+wrx /etc/hosts
	echo ""
	echo "sudo echo $INGRESS_IP $HOST >> /etc/hosts"
	echo $INGRESS_IP $HOST >> /etc/hosts
}

echo "If there are no entries for api.example.com and kiada.example.com in /etc/hosts, need to add."
echo $HR

host_entry='kiada.example.com'
if ! [[ $(grep $host_entry /etc/hosts) ]] 
then
	write_to_hosts $host_entry $ingress_ip 
else
	echo "$host_entry already exists in /etc/hosts"
fi
echo $HR


host_entry='api.example.com'
if ! [[ $(grep $host_entry /etc/hosts) ]] 
then
	write_to_hosts $host_entry $ingress_ip 
else
	echo "$host_entry already exists in /etc/hosts"
fi

enter


# This ingress object has these routes:
# kiada.example.com /
# api.example.com /quote
# api.example.com /questions

echo "curl --resolve kiada.example.com:80:$ingress_ip http://kiada.example.com/"
echo ""
curl --resolve kiada.example.com:80:$ingress_ip http://kiada.example.com/
enter

echo "curl --resolve api.example.com:80:$ingress_ip http://api.example.com/questions/random"
echo ""
curl --resolve api.example.com:80:$ingress_ip http://api.example.com/questions/random
enter

echo "curl --resolve api.example.com:80:$ingress_ip http://api.example.com/quote"
echo ""
curl --resolve api.example.com:80:$ingress_ip http://api.example.com/quote

enter_delete

echo "kubectl delete ns chp12-set1223"
kubectl delete ns chp12-set1223

echo $HR_TOP