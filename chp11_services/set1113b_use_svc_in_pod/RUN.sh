#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1113b_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1113b --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1113b --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""
kubectl apply -f $FULLPATH/kiada-stable-and-canary.yaml
echo ""


echo "kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1113b --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-001 -n=chp11-set1113b --timeout=120s
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp11-set1113b --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp11-set1113b --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/set1113b_svc_quote.yaml
kubectl apply -f $FULLPATH/set1113b_svc_quiz.yaml

echo $HR 

echo "kubectl get pods -n=chp11-set1113b -o wide --show-labels | sort"
kubectl get pods -n=chp11-set1113b -o wide --show-labels | sort
echo $HR 

echo "kubectl get svc -n=chp11-set1113b -o wide"
kubectl get svc -n=chp11-set1113b -o wide
echo $HR

echo "Start port-forward:"
enter

echo "Open a tunnel to this particular pod."
echo "Run 'curl http://localhost:8080' in a separate terminal."
echo "When done, press ctrl-c and continue on."
echo ""
echo "kubectl port-forward kiada-001 -n=chp11-set1113b 8080 8443"
kubectl port-forward kiada-001 -n=chp11-set1113b 8080 8443

enter_delete

echo "kubectl delete ns chp11-set1113b"
kubectl delete ns chp11-set1113b

echo $HR_TOP