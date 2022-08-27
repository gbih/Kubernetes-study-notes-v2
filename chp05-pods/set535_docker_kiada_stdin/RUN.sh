#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "kubectl apply -f $FULLPATH/set535_namespace.yaml"
kubectl apply -f $FULLPATH/set535_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set535_pod.yaml"
kubectl apply -f $FULLPATH/set535_pod.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/kiada-stdin -n=chp05-set535 --timeout=20s"
kubectl wait --for=condition=Ready=True pods/kiada-stdin -n=chp05-set535 --timeout=20s
echo ""

echo "kubectl get pod -n=chp05-set535 -o wide"
kubectl get pod -n=chp05-set535 -o wide
echo $HR

echo "IP=\$(kubectl get pod -n=chp05-set535 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp05-set535 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR


echo "curl $IP:8080"
echo ""
curl $IP:8080

enter


for i in {1..2}
do
  # Hack to send stdin via pipe to container using kubectl attach
  echo "date | kubectl attach kiada-stdin -i -n=chp05-set535"
  date | kubectl attach kiada-stdin -i -n=chp05-set535
  echo "curl $IP:8080"
  echo ""
  curl $IP:8080
  sleep 0.5
  echo $HR
done

echo ""

echo "kubectl delete ns chp05-set535"
kubectl delete ns chp05-set535

echo $HR_TOP
