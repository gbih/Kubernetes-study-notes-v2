#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP
kubectl apply -f $FULLPATH/set912_namespace.yaml
kubectl apply -f $FULLPATH/set912_pod.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set912 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada -n=chp09-set912 --timeout=120s
echo $HR

echo "kubectl get all -n=chp09-set912 -o wide"
kubectl get all -n=chp09-set912 -o wide
echo $HR

echo "kubectl exec kiada -n=chp09-set912 -- env"
kubectl exec kiada -n=chp09-set912 -- env
echo $HR

echo "kubectl logs kiada -n=chp09-set912"
kubectl logs kiada -n=chp09-set912
echo $HR

enter

kubectl apply -f $FULLPATH/set912_pod_shell.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/env-var-references-in-shell -n=chp09-set912 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/env-var-references-in-shell -n=chp09-set912 --timeout=120s
echo $HR

echo "kubectl exec env-var-references-in-shell -n=chp09-set912 -- env"
kubectl exec env-var-references-in-shell -n=chp09-set912 -- env
echo $HR

echo "kubectl logs env-var-references-in-shell -n=chp09-set912"
kubectl logs env-var-references-in-shell -n=chp09-set912
echo $HR 

echo "kubectl get events -n=chp09-set912"
kubectl get events -n=chp09-set912

enter_delete

echo "kubectl delete ns chp09-set912"
kubectl delete ns chp09-set912

echo $HR_TOP