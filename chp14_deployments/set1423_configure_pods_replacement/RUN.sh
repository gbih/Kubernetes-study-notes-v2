#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

# Order:
# MAXSURGE=0, MAXUNAVAILABLE=1
# MAXSURGE=1, MAXUNAVAILABLE=0
# MAXSURGE=1, MAXUNAVAILABLE=1

kubectl apply -f $FULLPATH/set1423_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1423 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1423 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

echo "Create Deployment v0.6"
echo "kubectl apply -f $FULLPATH/set1423_dep_v0.6.yaml"
kubectl apply -f $FULLPATH/set1423_dep_v0.6.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1423"
kubectl rollout status deployment kiada -n=chp14-set1423
enter

echo "kubectl get deploy kiada -n=chp14-set1423 -o wide"
kubectl get deploy kiada -n=chp14-set1423 -o wide
echo $HR

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime

enter

#####

# For some reason, we cannot curl to http:80 anymore

echo "In a separate brower, check the Ingress proxy server after upgrading the Deployment to v0.7"
echo ""

ingress_ip_kiada=$(kubectl get ing kiada -n=chp14-set1423 -o jsonpath={'.status.loadBalancer.ingress[0].ip'})
echo "Use these commands:"
# echo "for i in {1..1000}; do curl https://kiada.example.com  --resolve kiada.example.com:443:$ingress_ip -k; sleep 0.3; done"
echo "while true; do curl https://kiada.example.com  --resolve kiada.example.com:443:$ingress_ip -k; sleep 0.3; done"
enter


##### set1423_dep_v0.7_mSurge0_mUnavail1

echo "Update the Deployment by upgrading to v0.7 (maxSurge:0, maxUnavailable:1)"
echo "maxSurge:0 - Do not add Pods beyond the desired number of replicas (3)."
echo "maxUnavailable: 1 - Two pods must always be available. Can scale up and down."
echo ""

kubectl apply -f $FULLPATH/set1423_dep_v0.7_mSurge0_mUnavail1.yaml
echo $HR 

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime
echo $HR

echo "kubectl rollout status deployment kiada -n=chp14-set1423"
kubectl rollout status deployment kiada -n=chp14-set1423
echo $HR

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime

enter 

echo "Revert back to Deployment v0.6"
echo "kubectl apply -f $FULLPATH/set1423_dep_v0.6.yaml"
kubectl apply -f $FULLPATH/set1423_dep_v0.6.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1423"
kubectl rollout status deployment kiada -n=chp14-set1423
echo $HR 

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime

enter 

##### set1423_dep_v0.7_mSurge1_mUnavail0

echo "Update the Deployment by upgrading to v0.7 (maxSurge:1, maxUnavailable:0)"
echo "maxSurge:1 - At most 4 pods may exist at any given time (4)."
echo "maxUnavailable: 0 - At least 3 pods must be available throughout the update process. Cannot scale down."
echo ""

kubectl apply -f $FULLPATH/set1423_dep_v0.7_mSurge1_mUnavail0.yaml
echo $HR 

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime
echo $HR

echo "kubectl rollout status deployment kiada -n=chp14-set1423"
kubectl rollout status deployment kiada -n=chp14-set1423
echo $HR

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime

enter 

echo "Revert back to Deployment v0.6"
echo "kubectl apply -f $FULLPATH/set1423_dep_v0.6.yaml"
kubectl apply -f $FULLPATH/set1423_dep_v0.6.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1423"
kubectl rollout status deployment kiada -n=chp14-set1423
echo $HR 

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime

enter 

##### set1423_dep_v0.7_mSurge1_mUnavail1

echo "Update the Deployment by upgrading to v0.7 (maxSurge 1, maxUnavailable 1)"
echo "maxSurge:1 - At most 4 pods may exist at any given time (4)."
echo "maxUnavailable: 1 - Two pods must always be available. Can scale up and down."
echo ""

kubectl apply -f $FULLPATH/set1423_dep_v0.7_mSurge1_mUnavail1.yaml
echo $HR 

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime
echo $HR

echo "kubectl rollout status deployment kiada -n=chp14-set1423"
kubectl rollout status deployment kiada -n=chp14-set1423
echo $HR

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime

enter 

echo "Revert back to Deployment v0.6"
echo "kubectl apply -f $FULLPATH/set1423_dep_v0.6.yaml"
kubectl apply -f $FULLPATH/set1423_dep_v0.6.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1423"
kubectl rollout status deployment kiada -n=chp14-set1423
echo $HR 

echo "kubectl get rs -n=chp14-set1423 --show-labels"
kubectl get rs -n=chp14-set1423 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1423 -l app=kiada -L ver --sort-by=.status.startTime

##### Clean-up

enter_delete

echo "kubectl delete ns chp14-set1423"
kubectl delete ns chp14-set1423

echo $HR_TOP