#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

echo "In a separate window, run this:"
echo "watch kubectl alpha events deploy quiz -n=chp15-set1511"
enter

kubectl apply -f $FULLPATH/set1511_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1511 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1511 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

echo "Show a single pod created directly via the kiada Deployment:"
echo ""
echo 'single_pod=$(kubectl get pods -l parent=deploy.kiada -n=chp15-set1511 -o name | head -1)'
single_pod=$(kubectl get pods -l parent=deploy.kiada -n=chp15-set1511 -o name | head -1)
echo $single_pod
echo $HR

echo "kubectl wait --for=condition=Ready=True $single_pod -n=chp15-set1511 --timeout=120s"
kubectl wait --for=condition=Ready=True $single_pod -n=chp15-set1511 --timeout=120s
enter

#####

echo "Try to scale the quiz Deployment to 3 replicas"
echo ""
echo "kubectl scale deploy quiz -n=chp15-set1511 --replicas 3"
kubectl scale deploy quiz -n=chp15-set1511 --replicas 3
echo $HR 

echo "kubectl rollout status deploy quiz -n=chp15-set1511 --timeout=20s"
kubectl rollout status deploy quiz -n=chp15-set1511 --timeout=20s
echo $HR

# sleep 15

echo "kubectl get pods -l app=quiz -n=chp15-set1511"
kubectl get pods -l app=quiz -n=chp15-set1511
echo $HR 

echo "Look for pods that are not running properly:"
echo "kubectl get pods -n=chp15-set1511 | grep -E CrashLoopBackOff\|OutOfcpu\|Evicted\|Completed\|OOMKilled\|Error\|ContainerStatusUnknown"
kubectl get pods -n=chp15-set1511 | grep -E CrashLoopBackOff\|OutOfcpu\|Evicted\|Completed\|OOMKilled\|Error\|ContainerStatusUnknown
echo ""

echo "Select a single bad pod:"
echo "bad_pod=$(kubectl get pods -n=chp15-set1511 --no-headers | grep -E CrashLoopBackOff\|OutOfcpu\|Evicted\|Completed\|OOMKilled\|Error\|ContainerStatusUnknown | head -1 | cut -d ' ' -f 1)"
bad_pod=$(kubectl get pods -n=chp15-set1511 --no-headers | grep -E CrashLoopBackOff\|OutOfcpu\|Evicted\|Completed\|OOMKilled\|Error\|ContainerStatusUnknown | head -1 | cut -d ' ' -f 1)
echo "Bad pod: $bad_pod"
echo ""

echo "Show logs for bad pod $bad_pod:"
echo ""
echo "kubectl logs $bad_pod -n=chp15-set1511 -c mongo | grep DBException | jq"
kubectl logs $bad_pod -n=chp15-set1511 -c mongo | grep DBException | jq

echo $HR 

echo "This error message indicates you cannot use the same data directory in multiple instances of MongoDB."
echo "Instead, we must use a dedicated PersistentVolume for each MongoDB replica set (which is different from a Kubernetes ReplicaSet resource)."
echo "We do this creating a separate Deployment, Service, and PVC for each replica."

##### Clean-up

enter_delete

echo "kubectl delete ns chp15-set1511"
kubectl delete ns chp15-set1511

echo $HR_TOP