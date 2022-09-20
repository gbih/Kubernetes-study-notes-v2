#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

##### Set-up

echo $HR_TOP

kubectl apply -f $FULLPATH/set1231_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1231 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1231 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

kubectl apply -f $FULLPATH/set1231_dns-test.yaml
kubectl apply -f $FULLPATH/set1231_fun_404.yaml
kubectl apply -f $FULLPATH/set1231_ingress_tls.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1231 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1231 --timeout=120s
echo $HR 

enter

##### Main tasks

echo "Generate private key, certificate and Secret via CLI"
echo ""
echo """openssl req -x509 -newkey rsa:4096 -keyout example.key -out example.crt \
	-sha256 -days 7300 -nodes \
	-subj '/CN='.example.com \
	-addext 'subjectAltName = DNS:*.example.com'
"""
openssl req -x509 -newkey rsa:4096 -keyout example.key -out example.crt \
	-sha256 -days 7300 -nodes \
	-subj '/CN='.example.com \
	-addext 'subjectAltName = DNS:*.example.com'
echo $HR


# This may be more secure to run via CLI, rather than embed tls data in YAML manifest.
echo "Create secret via CLI:"
echo ""
echo "kubectl create secret tls tls-example-com --cert=example.crt --key=example.key -n=chp12-set1231"
kubectl create secret tls tls-example-com --cert=example.crt --key=example.key -n=chp12-set1231
enter

echo "kubectl describe secret tls-example-com -n=chp12-set1231"
kubectl describe secret tls-example-com -n=chp12-set1231
echo $HR 

echo "Add the TLS secret to the Ingress. Make sure to update our ingress object."
echo ""
echo "kubectl apply -f $FULLPATH/set1231_ingress_tls.yaml"
kubectl apply -f $FULLPATH/set1231_ingress_tls.yaml
enter

##### Tests

echo "Access the Ingress through TLS"
echo ""

ingress_ip=$(kubectl get ing kiada -n=chp12-set1231 -o jsonpath={'.status.loadBalancer.ingress[0].ip'})

echo "Check our Ingress rules and routes:"
echo ""
echo "kubectl describe ing kiada -n=chp12-set1231"
kubectl describe ing kiada -n=chp12-set1231
enter

echo "curl https://kiada.example.com  --resolve kiada.example.com:443:$ingress_ip -k -v"
echo ""
curl https://kiada.example.com  --resolve kiada.example.com:443:$ingress_ip -k -v
enter

echo "curl https://api.example.com/questions/random --resolve api.example.com:443:$ingress_ip -k -v"
echo ""
curl https://api.example.com/questions/random --resolve api.example.com:443:$ingress_ip -k -v
enter

echo "curl https://api.example.com/quote --resolve api.example.com:443:$ingress_ip -k -v"
echo ""
curl https://api.example.com/quote --resolve api.example.com:443:$ingress_ip -k -v

enter_delete

##### Clean-up

echo "Delete data used for TLS:"
rm ./example.crt example.key

echo "kubectl delete ns chp12-set1231"
kubectl delete ns chp12-set1231

echo $HR_TOP