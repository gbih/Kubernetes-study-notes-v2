#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1422_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1422 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1422 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

echo "Create Deployment v0.6"
echo "kubectl apply -f $FULLPATH/set1422_deployment_kiada_v0.6.yaml"
kubectl apply -f $FULLPATH/set1422_deployment_kiada_v0.6.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1422"
kubectl rollout status deployment kiada -n=chp14-set1422
enter

echo "kubectl get deploy kiada -n=chp14-set1422 -o wide"
kubectl get deploy kiada -n=chp14-set1422 -o wide
echo $HR

echo "kubectl get rs -n=chp14-set1422 --show-labels"
kubectl get rs -n=chp14-set1422 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1422 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1422 -l app=kiada -L ver --sort-by=.status.startTime

enter

#####

# For some reason, we cannot curl to http:80 anymore

echo "In a separate brower, check the Ingress proxy server after upgrading the Deployment to v0.6"
echo ""

ingress_ip_kiada=$(kubectl get ing kiada -n=chp14-set1422 -o jsonpath={'.status.loadBalancer.ingress[0].ip'})
echo "Use these commands:"
echo "for i in {1..1000}; do curl https://kiada.example.com  --resolve kiada.example.com:443:$ingress_ip -k; sleep 0.3; done"

enter

#####

echo "Update the Deployment by upgrading to v0.7, using the RollingUpdate strategy."
echo ""

echo "kubectl apply -f $FULLPATH/set1422_deployment_kiada_v0.7.yaml"
kubectl apply -f $FULLPATH/set1422_deployment_kiada_v0.7.yaml
echo $HR 

echo "Check immediately:"
echo "kubectl get rs -n=chp14-set1422 --show-labels"
kubectl get rs -n=chp14-set1422 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1422 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1422 -l app=kiada -L ver --sort-by=.status.startTime
echo $HR

echo "kubectl rollout status deployment kiada -n=chp14-set1422"
kubectl rollout status deployment kiada -n=chp14-set1422
echo $HR

echo "kubectl get rs -n=chp14-set1422 --show-labels"
kubectl get rs -n=chp14-set1422 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1422 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1422 -l app=kiada -L ver --sort-by=.status.startTime

##### Clean-up

enter_delete

echo "kubectl delete ns chp14-set1422"
kubectl delete ns chp14-set1422

echo $HR_TOP