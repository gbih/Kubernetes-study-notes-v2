#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP


echo "kubectl apply -f $FULLPATH/set723_namespace.yaml"
kubectl apply -f $FULLPATH/set723_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set723_pod.yaml"
kubectl apply -f $FULLPATH/set723_pod.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quote -n=chp07-set723 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quote -n=chp07-set723 --timeout=120s
echo $HR

echo "kubectl get all -n=chp07-set723 -o wide"
kubectl get all -n=chp07-set723 -o wide
echo $HR

echo "IP=\$(kubectl get pod -n=chp07-set723 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp07-set723 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR

echo "Retrieve a random question through the quote API."
echo "We set the fortune container to update every 9 seconds."
echo ""
for i in {1..3}
do
	echo "curl $IP:80/quote"
	curl $IP:80/quote
	echo $HR
	if [ "$i" -lt 3 ]; then sleep 5; fi
done



echo "Display the contents of the file using either of the following two commands:"
echo ""
echo "kubectl -n=chp07-set723 exec quote -c quote-writer -- cat /var/local/output/quote"
kubectl -n=chp07-set723 exec quote -c quote-writer -- cat /var/local/output/quote
echo $HR
echo "kubectl -n=chp07-set723 exec quote -c nginx -- cat /usr/share/nginx/html/quote"
kubectl -n=chp07-set723 exec quote -c nginx -- cat /usr/share/nginx/html/quote

enter


echo "Get the name of the node that runs the pod":
echo "kubectl get pod quote -n=chp07-set723 -o json | jq .spec.nodeName"
kubectl get pod quote -n=chp07-set723 -o json | jq .spec.nodeName
echo $HR


echo "Check logs"
echo ""
echo "kubectl logs quote -c quote-writer -n=chp07-set723"
kubectl logs quote -c quote-writer -n=chp07-set723
echo $HR


echo "Check events"
echo ""
echo "kubectl get events -n=chp07-set723 | grep -i quote-writer"
kubectl get events -n=chp07-set723 | grep -i quote-writer
echo $HR


echo "kubectl delete ns chp07-set723"
kubectl delete ns chp07-set723

echo $HR_TOP