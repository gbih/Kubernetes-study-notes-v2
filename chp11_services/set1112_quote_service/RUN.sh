#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1112_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1112 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1112 --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp11-set1112 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp11-set1112 --timeout=120s

echo $HR 

kubectl apply -f $FULLPATH/set1112_svc_quote.yaml
kubectl apply -f $FULLPATH/set1112_svc_quiz.yaml
echo $HR 

echo "kubectl get pods -n=chp11-set1112 --show-labels | sort"
kubectl get pods -n=chp11-set1112 --show-labels | sort
echo $HR 

echo "kubectl get pvc -n=chp11-set1112"
kubectl get pvc -n=chp11-set1112
echo $HR 

echo "kubectl get pv"
kubectl get pv
echo $HR 

echo "kubectl get svc -n=chp11-set1112 -o wide"
kubectl get svc -n=chp11-set1112 -o wide
echo $HR 

quiz_ip=$(kubectl get svc quiz --no-headers -n=chp11-set1112 -o custom-columns=":spec.clusterIP")
echo "quiz_ip" $quiz_ip

quote_ip=$(kubectl get svc quote --no-headers -n=chp11-set1112 -o custom-columns=":spec.clusterIP")
echo "quote_ip" $quote_ip
echo $HR 

sleep 0.5

curl $quiz_ip
echo $HR 

curl $quote_ip
echo $HR 

enter_delete

echo "kubectl delete ns chp11-set1112"
kubectl delete ns chp11-set1112

echo $HR_TOP