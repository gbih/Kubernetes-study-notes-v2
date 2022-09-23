#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1425_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1425 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp14-set1425 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

echo "kubectl apply -f $FULLPATH/set1425_dep_v0.7_mSurge0_mUnavail1.yaml"
kubectl apply -f $FULLPATH/set1425_dep_v0.7_mSurge0_mUnavail1.yaml
echo $HR 

echo "kubectl rollout status deployment kiada  -n=chp14-set1425"
kubectl rollout status deployment kiada  -n=chp14-set1425
echo $HR

echo "kubectl get all -n=chp14-set1425"
kubectl get all -n=chp14-set1425

enter



echo "Trying updating to Deployment v0.8"
echo "This is a broken deployment:"
echo "kubectl apply -f $FULLPATH/set1425_dep_v0.8_minReadySeconds60.yaml"
kubectl apply -f $FULLPATH/set1425_dep_v0.8_minReadySeconds60.yaml
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1425  --timeout=20s"
kubectl rollout status deployment kiada -n=chp14-set1425  --timeout=20s
echo $HR

echo "kubectl describe deploy kiada -n=chp14-set1425 | tail -12"
kubectl describe deploy kiada -n=chp14-set1425 | tail -12
echo $HR 

echo "kubectl get rs -n=chp14-set1425 -o wide"
kubectl get rs -n=chp14-set1425 -o wide

enter

#####

echo "Rollback a Deployment:"
echo ""
echo "kubectl rollout undo deployment kiada -n=chp14-set1425"
kubectl rollout undo deployment kiada -n=chp14-set1425
echo $HR 

echo "kubectl rollout status deployment kiada -n=chp14-set1425  --timeout=20s"
kubectl rollout status deployment kiada -n=chp14-set1425  --timeout=20s
echo $HR

echo "kubectl describe deploy kiada -n=chp14-set1425 | tail -12"
kubectl describe deploy kiada -n=chp14-set1425 | tail -12
echo $HR 

echo "kubectl get rs -n=chp14-set1425 -o wide"
kubectl get rs -n=chp14-set1425 -o wide

enter

#####

echo "Display a Deployment's Rollout History:"
echo ""
echo "kubectl rollout history deployment kiada -n=chp14-set1425"
kubectl rollout history deployment kiada  -n=chp14-set1425
echo $HR 

enter 

echo "kubectl get rs -n=chp14-set1425 -o wide"
kubectl get rs -n=chp14-set1425 -o wide

##### Clean-up

enter_delete

echo "kubectl delete ns chp14-set1425"
kubectl delete ns chp14-set1425

echo $HR_TOP