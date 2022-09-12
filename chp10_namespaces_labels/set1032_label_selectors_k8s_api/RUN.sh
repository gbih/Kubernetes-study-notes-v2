#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Create namespace first"
kubectl apply -f $FULLPATH/set1032_namespace.yaml
sleep 1
echo $HR

echo "Next, create objects"
kubectl apply -f $FULLPATH/kiada --recursive
echo ""

kubectl apply -f $FULLPATH/quiz --recursive
echo ""

kubectl apply -f $FULLPATH/quote --recursive
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp10-set1032 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp10-set1032 --timeout=120s
echo $HR 

enter

echo "kubectl get nodes"
kubectl get nodes
echo $HR 

echo "kubectl label node worker1 node-role=front-end --overwrite"
kubectl label node worker1 node-role=front-end --overwrite
echo $HR

echo "kubectl get node -l node-role=front-end -L node-role -n=chp10-set1032"
kubectl get node -l node-role=front-end -L node-role -n=chp10-set1032
enter

echo "kubectl apply -f $FULLPATH/set1032_pod_kiada_front_end.yaml"
kubectl apply -f $FULLPATH/set1032_pod_kiada_front_end.yaml
echo $HR 

echo "kubectl get pod kiada-front-end -o wide -n=chp10-set1032"
kubectl get pod kiada-front-end -o wide -n=chp10-set1032
echo $HR 

echo "kubectl delete pod/kiada-front-end -n=chp10-set1032"
kubectl delete pod/kiada-front-end -n=chp10-set1032
enter

echo "Delete pod and make sure the recreated pod lands on the front-end node"
echo ""
echo "kubectl apply -f $FULLPATH/set1032_pod_kiada_front_end.yaml"
kubectl apply -f $FULLPATH/set1032_pod_kiada_front_end.yaml
echo $HR 

echo "kubectl get pod kiada-front-end -o wide -n=chp10-set1032"
kubectl get pod kiada-front-end -o wide -n=chp10-set1032
enter


echo "Using operators with PVC and PV"
echo ""

echo "kubectl apply -f $FULLPATH/set1032_persistent-volumes.yaml"
kubectl apply -f $FULLPATH/set1032_persistent-volumes.yaml
echo $HR

echo "kubectl get pv -l type --show-labels"
kubectl get pv -l type --show-labels
echo $HR

echo "kubectl apply -f $FULLPATH/set1032_pvc_equality_selector.yaml"
kubectl apply -f $FULLPATH/set1032_pvc_equality_selector.yaml
echo $HR 

echo "kubectl get pvc ssd-claim -n=chp10-set1032 --show-labels"
kubectl get pvc ssd-claim -n=chp10-set1032 --show-labels
echo $H$


echo "kubectl apply -f $FULLPATH/set1032_pvc_set_selector.yaml"
kubectl apply -f $FULLPATH/set1032_pvc_set_selector.yaml
echo $HR 

echo "kubectl get pvc ssd-claim-set -n=chp10-set1032 --show-labels"
kubectl get pvc ssd-claim-set -n=chp10-set1032 --show-labels
echo $HR


echo "kubectl delete ns chp10-set1032"
kubectl delete ns chp10-set1032

echo $HR_TOP