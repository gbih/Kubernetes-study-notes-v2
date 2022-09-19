#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

kubectl apply -f $FULLPATH/set1163_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1163 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp11-set1163 --timeout=120s
echo $HR 

kubectl apply -f $FULLPATH/quiz --recursive
echo ""
kubectl apply -f $FULLPATH/quote --recursive
echo ""

kubectl apply -f $FULLPATH/set1163_kiada-stable-and-canary.yaml
echo ""

kubectl apply -f $FULLPATH/set1163_svc_loadbalancer_kiada.yaml
kubectl apply -f $FULLPATH/set1163_svc_quote.yaml
kubectl apply -f $FULLPATH/set1163_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1163_dns-test.yaml

enter

echo "The pod quote-readiness has a readinessProbe check added to the nginx container portion:"
echo """
  containers:
  - name: quote-writer
    image: luksa/quote-writer:0.1
    imagePullPolicy: Always
    volumeMounts:
    - name: shared
      mountPath: /var/local/output
  - name: nginx
    image: nginx:alpine
    volumeMounts:
    - name: shared
      mountPath: /usr/share/nginx/html
      readOnly: true
    ports:
    - name: http
      containerPort: 80
    readinessProbe:
      failureThreshold: 1
      httpGet:
        port: 80
        path: /quote
        scheme: HTTP
"""



kubectl apply -f $FULLPATH/set1163_pod_quote_readiness.yaml
echo $HR
echo "kubectl wait --for=condition=Ready=True pods/quote-readiness -n=chp11-set1163 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quote-readiness -n=chp11-set1163 --timeout=120s
enter


echo "kubectl get pods/quote-readiness -n chp11-set1163"
kubectl get pods/quote-readiness -n chp11-set1163
echo $HR


echo "Now, remove the 'quote' file and see the readinessProbe fail:"
echo ""

echo "kubectl exec pods/quote-readiness -n=chp11-set1163 -c quote-writer -- rm /var/local/output/quote"
kubectl exec pods/quote-readiness -n=chp11-set1163 -c quote-writer -- rm /var/local/output/quote
echo ""
echo "kubectl wait --for=condition=Ready=False pods/quote-readiness -n=chp11-set1163 --timeout=120s"
kubectl wait --for=condition=Ready=False pods/quote-readiness -n=chp11-set1163 --timeout=120s
enter

echo "kubectl get pods/quote-readiness -n chp11-set1163"
kubectl get pods/quote-readiness -n chp11-set1163
echo $HR


#####

echo "Here, we check dependencies in the readinessProbe."

echo "The pod kiada-readiness has readinessProbe checks added to both containers:"
echo """
  containers:
  - name: kiada
    image: luksa/kiada:0.5
    imagePullPolicy: Always
    ports:
    - name: http
      containerPort: 8080
    readinessProbe:
      httpGet:
        port: 8080
        path: /healthz/ready
        scheme: HTTP
  - name: envoy
    image: envoyproxy/envoy:v1.14.1
    volumeMounts:
    - name: etc-envoy
      mountPath: /etc/envoy
      readOnly: true
    ports:
    - name: https
      containerPort: 8443
    - name: admin
      containerPort: 9901
    readinessProbe:
      httpGet:
        port: admin
        path: /ready
"""

kubectl apply -f $FULLPATH/set1163_pod_kiada_readiness.yaml
echo ""
echo "kubectl wait --for=condition=Ready=True pods/kiada-readiness -n=chp11-set1163 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/kiada-readiness -n=chp11-set1163 --timeout=120s
echo $HR

echo "kubectl get pods/kiada-readiness -n chp11-set1163"
kubectl get pods/kiada-readiness -n chp11-set1163
enter


echo "kubectl logs pods/kiada-readiness -n chp11-set1163"
kubectl logs pods/kiada-readiness -n chp11-set1163

enter_delete

echo "kubectl delete ns chp11-set1163"
kubectl delete ns chp11-set1163

echo $HR_TOP