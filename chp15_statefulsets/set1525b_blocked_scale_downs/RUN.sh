#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

echo "In a separate window, run this:"
echo "watch kubectl get sts demo-ordered -n=chp15-set1525b"
enter

kubectl apply -f $FULLPATH/set1525b_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1525b --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1525b --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/set1525b_sts_demo.yaml"
kubectl apply -f $FULLPATH/set1525b_sts_demo.yaml
echo $HR 

echo "kubectl rollout status sts demo-ordered -n=chp15-set1525b"
kubectl rollout status sts demo-ordered -n=chp15-set1525b
echo $HR

echo "kubectl get sts -n=chp15-set1525b -o wide"
kubectl get sts -n=chp15-set1525b -o wide
echo $HR

echo "kubectl get pods -n=chp15-set1525b"
kubectl get pods -n=chp15-set1525b

enter

echo "Fail the readiness probe in the Pod demo-ordered-0 by removing /tmp/ready"
echo ""

echo "kubectl exec demo-ordered-0 -n=chp15-set1525b -- rm /tmp/ready"
kubectl exec demo-ordered-0 -n=chp15-set1525b -- rm /tmp/ready
echo $HR 

echo "kubectl wait --for=condition=Ready=False pods/demo-ordered-0 -n=chp15-set1525b --timeout=20s"
kubectl wait --for=condition=Ready=False pods/demo-ordered-0 -n=chp15-set1525b --timeout=20s
echo $HR 

echo "kubectl get sts -n=chp15-set1525b -o wide"
kubectl get sts -n=chp15-set1525b -o wide
echo $HR

echo "kubectl get pods -n=chp15-set1525b"
kubectl get pods -n=chp15-set1525b

enter 

echo "Scale the StatefulSet to two replicas."
echo "We can see that the StatefulSet controller does nothing."
echo "The implication is the controllers completes the scale operation when the Pod is ready."
echo ""

echo "kubectl scale sts demo-ordered -n=chp15-set1525b --replicas=2"
kubectl scale sts demo-ordered -n=chp15-set1525b --replicas=2
echo $HR 

echo "kubectl rollout status sts demo-ordered -n=chp15-set1525b --timeout 10s"
kubectl rollout status sts demo-ordered -n=chp15-set1525b --timeout 10s
echo $HR

echo "kubectl get sts -n=chp15-set1525b -o wide"
kubectl get sts -n=chp15-set1525b -o wide
echo $HR

echo "kubectl get pods -n=chp15-set1525b"
kubectl get pods -n=chp15-set1525b

enter 

echo "The controller completes the scale operation when the Pod is ready."
echo "We can make the readiness probe of demo-ordered-0 Pod succeed by recreating the /tmp/ready file."
echo ""

echo "kubectl exec demo-ordered-0 -n=chp15-set1525b -- touch /tmp/ready"
kubectl exec demo-ordered-0 -n=chp15-set1525b -- touch /tmp/ready
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/demo-ordered-0 -n=chp15-set1525b --timeout=20s"
kubectl wait --for=condition=Ready=True pods/demo-ordered-0 -n=chp15-set1525b --timeout=20s
echo $HR 

echo "kubectl rollout status sts demo-ordered -n=chp15-set1525b"
kubectl rollout status sts demo-ordered -n=chp15-set1525b
echo $HR

sleep 3

echo "kubectl get sts -n=chp15-set1525b -o wide"
kubectl get sts -n=chp15-set1525b -o wide
echo $HR

echo "kubectl get pods -n=chp15-set1525b"
kubectl get pods -n=chp15-set1525b

##### Clean-up

enter_delete

echo "kubectl delete ns chp15-set1525b"
kubectl delete ns chp15-set1525b

echo $HR_TOP