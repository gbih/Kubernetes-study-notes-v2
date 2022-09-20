#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

##### Set-up

echo $HR_TOP

kubectl apply -f $FULLPATH/set1251_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1251 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp12-set1251 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/SETUP --recursive
echo ""

kubectl apply -f $FULLPATH/set1251_dns-test.yaml
kubectl apply -f $FULLPATH/set1251_fun_404.yaml
echo ""

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1251 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp12-set1251 --timeout=120s
echo $HR 

enter

##### Main tasks

# 12.5.1 material

echo "Find ingress classes in the cluster"
echo ""

echo "kubectl get ingressclasses"
kubectl get ingressclasses
echo $HR 

echo "kubectl describe ingressclasses"
kubectl describe ingressclasses

enter

echo "kubectl get ingressclasses nginx -o yaml"
echo ""
kubectl get ingressclasses nginx -o yaml

enter 


# 12.5.2 material

echo "Specify the IngressClass in the Ingress object:"
echo ""
echo "kubectl apply -f $FULLPATH/set1251_ingress_class_name.yaml"
kubectl apply -f $FULLPATH/set1251_ingress_class_name.yaml
echo $HR 

echo "kubectl get ing kiada -n=chp12-set1251 -o jsonpath={'.spec.ingressClassName'}"
kubectl get ing kiada -n=chp12-set1251 -o jsonpath={'.spec.ingressClassName'}
echo ""

enter


# 12.5.3 material

echo "Adding parameters to an IngressClass"
echo ""
echo "kubectl apply -f $FULLPATH/set1251_ingress_params.yaml"
kubectl apply -f $FULLPATH/set1251_ingress_params.yaml
echo $HR

echo "kubectl describe ingressclass custom-ingress-class"
kubectl describe ingressclass custom-ingress-class

enter

# 12.6.1 material

echo "Using a custom object to configure Ingress routing"
echo ""
echo "kubectl apply -f $FULLPATH/set1251_ingress_resource_backend.yaml"
kubectl apply -f $FULLPATH/set1251_ingress_resource_backend.yaml
echo $HR 

echo "kubectl describe ingressclass custom-ingress-class -n=chp12-set1251"
kubectl describe ingressclass custom-ingress-class -n=chp12-set1251

enter_delete

#### Clean-up

echo "kubectl delete ns chp12-set1251"
kubectl delete ns chp12-set1251

echo $HR_TOP