#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up


kubectl apply -f $FULLPATH/set1424_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1424 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1424 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

echo "Create Deployment v0.6"
echo "kubectl apply -f $FULLPATH/set1424_dep_v0.6.yaml"
kubectl apply -f $FULLPATH/set1424_dep_v0.6.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1424"
kubectl rollout status deployment kiada -n=chp14-set1424
enter

echo "kubectl get deploy kiada -n=chp14-set1424 -o wide"
kubectl get deploy kiada -n=chp14-set1424 -o wide
echo $HR

echo "kubectl get rs -n=chp14-set1424 --show-labels"
kubectl get rs -n=chp14-set1424 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1424 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1424 -l app=kiada -L ver --sort-by=.status.startTime

enter

#####

# For some reason, we cannot curl to http:80 anymore

echo "In a separate brower, run these command while upgrading the Deployment to v0.7"
echo ""
echo "Pausing the rollout process:"
echo "kubectl rollout pause deployment kiada -n=chp14-set1424"
echo ""
echo "Resuming a paused rollout:"
echo "kubectl rollout resume deployment kiada -n=chp14-set1424"

enter

kubectl apply -f $FULLPATH/set1424_dep_v0.7_mSurge0_mUnavail1.yaml
echo $HR 

echo "kubectl get rs -n=chp14-set1424 --show-labels"
kubectl get rs -n=chp14-set1424 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1424 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1424 -l app=kiada -L ver --sort-by=.status.startTime
echo $HR

echo "kubectl rollout status deployment kiada -n=chp14-set1424"
kubectl rollout status deployment kiada -n=chp14-set1424
echo $HR

echo "kubectl get rs -n=chp14-set1424 --show-labels"
kubectl get rs -n=chp14-set1424 --show-labels
echo ""
echo "kubectl get pods -n=chp14-set1424 -l app=kiada -L ver --sort-by=.status.startTime"
kubectl get pods -n=chp14-set1424 -l app=kiada -L ver --sort-by=.status.startTime

enter 

##### Clean-up

enter_delete

echo "kubectl delete ns chp14-set1424"
kubectl delete ns chp14-set1424

echo $HR_TOP