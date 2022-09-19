#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1162_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1162 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1162 --timeout=120s
echo $HR 

# Only create pod kiada-001
echo "Create pod kiada-001:"
echo ""
kubectl apply -f $FULLPATH/set1162_kiada-001-stable-and-canary.yaml
kubectl apply -f $FULLPATH/set1162_svc_loadbalancer_kiada.yaml

echo "kubectl apply -f $FULLPATH/set1162_kiada_mock_readiness.yaml"
kubectl apply -f $FULLPATH/set1162_kiada_mock_readiness.yaml
echo $HR

echo "Check the pod readiness status:"
echo ""
echo "kubectl get pods/kiada-mock-readiness -n=chp11-set1162"
kubectl get pods/kiada-mock-readiness -n=chp11-set1162

enter

echo "Check the endpoints of kiada"
echo ""
echo "kubectl get endpoints kiada -n=chp11-set1162 -o yaml"
echo ""
kubectl get endpoints kiada -n=chp11-set1162 -o yaml

enter

echo "Check the endpointslices:"
echo ""
echo "kubectl get endpointslices -l kubernetes.io/service-name=kiada -n=chp11-set1162 -o yaml"
echo ""
kubectl get endpointslices -l kubernetes.io/service-name=kiada -n=chp11-set1162 -o yaml
echo $HR 

enter

echo "Enable the readiness probe to succeed by creating the /var/ready file in the container:"
echo ""
echo "kubectl exec kiada-mock-readiness -n=chp11-set1162 -c kiada -- touch /var/ready"
kubectl exec kiada-mock-readiness -n=chp11-set1162 -c kiada -- touch /var/ready
echo $HR 


echo "kubectl wait --for=condition=Ready=True pods/kiada-mock-readiness -n=chp11-set1162 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-mock-readiness -n=chp11-set1162 --timeout=120s
echo $HR 



echo "Check the pod readiness status now:"
echo ""
echo "kubectl get pods/kiada-mock-readiness -n=chp11-set1162"
kubectl get pods/kiada-mock-readiness -n=chp11-set1162
echo $HR 

enter

echo "Remove the pod from the service again:"
echo ""
echo "kubectl exec kiada-mock-readiness -n=chp11-set1162 -c kiada -- rm /var/ready"
kubectl exec kiada-mock-readiness -n=chp11-set1162 -c kiada -- rm /var/ready
echo $HR

echo "kubectl wait --for=condition=Ready=False pods/kiada-mock-readiness -n=chp11-set1162 --timeout=120s"
kubectl wait --for=condition=Ready=False pods/kiada-mock-readiness -n=chp11-set1162 --timeout=120s
echo $HR 


echo "Check the pod readiness status one last time:"
echo ""
echo "kubectl get pods/kiada-mock-readiness -n=chp11-set1162"
kubectl get pods/kiada-mock-readiness -n=chp11-set1162
echo $HR 

enter

echo "kubectl get events -n=chp11-set1162"
kubectl get events -n=chp11-set1162

enter_delete

echo "kubectl delete ns chp11-set1162"
kubectl delete ns chp11-set1162

echo $HR_TOP