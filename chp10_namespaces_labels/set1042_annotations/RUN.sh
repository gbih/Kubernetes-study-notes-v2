#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Create namespace first"
kubectl apply -f $FULLPATH/set1042_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp10-set1042 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp10-set1042 --timeout=120s

echo $HR

kubectl apply -f $FULLPATH/kiada --recursive
echo ""

kubectl apply -f $FULLPATH/quiz --recursive
echo ""

kubectl apply -f $FULLPATH/quote --recursive
enter

echo "Add an annotation to one of the pods, imperatively"
echo ""
echo "kubectl annotate pod/kiada-001 created-by='George Baptista <george@omame.com>' -n=chp10-set1042 --overwrite"
kubectl annotate pod/kiada-001 created-by='George Baptista <george@omame.com>' -n=chp10-set1042 --overwrite
echo $HR 

echo "kubectl get pod/kiada-001 -n=chp10-set1042 -o jsonpath='{.metadata.annotations.created-by}'"
kubectl get pod/kiada-001 -n=chp10-set1042 -o jsonpath='{.metadata.annotations.created-by}'
echo ""
enter

echo "Apply annotations declaratively in YAML manifest"
echo ""
echo "kubectl apply -f $FULLPATH/set1042_pod_kiada_front_end.yaml"
kubectl apply -f $FULLPATH/set1042_pod_kiada_front_end.yaml
echo $HR 

echo "kubectl get pods -n=chp10-set1032b --field-selector spec.nodeName=worker1 -o=custom-columns='NAME:.metadata.name,Namespace:.metadata.namespace,Node:.spec.nodeName' | sort"
echo ""
echo "ANNOTATION COLUMNS:"
kubectl get pods/kiada-front-end -n=chp10-set1042 \
-o=custom-columns='CREATED-BY:.metadata.annotations.created-by,MANAGED:.metadata.annotations.managed,REVISION:.metadata.annotations.revision,COMPANY:.metadata.company'
enter

## For reference
# annotations:
#   created-by: George Baptista <george@omame.com>
#   managed: 'yes'
#   revision: '3'
#   company: Studio Omame

echo "Updating annotations"
echo ""
echo "kubectl annotate pod/kiada-front-end -n=chp10-set1042 created-by="Izumi Hiroshima" --overwrite"
kubectl annotate pod/kiada-front-end -n=chp10-set1042 created-by="Izumi Hiroshima" --overwrite
echo $HR 

echo "kubectl get pods -n=chp10-set1032b --field-selector spec.nodeName=worker1 -o=custom-columns='NAME:.metadata.name,Namespace:.metadata.namespace,Node:.spec.nodeName' | sort"
echo ""
echo "ANNOTATION COLUMNS:"
kubectl get pods/kiada-front-end -n=chp10-set1042 \
-o=custom-columns='CREATED-BY:.metadata.annotations.created-by,MANAGED:.metadata.annotations.managed,REVISION:.metadata.annotations.revision,COMPANY:.metadata.company'
enter

echo "Removing annotations"
echo ""
echo "kubectl annotate pod/kiada-front-end -n=chp10-set1042 created-by- --overwrite"
kubectl annotate pod/kiada-front-end -n=chp10-set1042 created-by- --overwrite
echo $HR 

echo "kubectl get pods -n=chp10-set1032b --field-selector spec.nodeName=worker1 -o=custom-columns='NAME:.metadata.name,Namespace:.metadata.namespace,Node:.spec.nodeName' | sort"
echo ""
echo "ANNOTATION COLUMNS:"
kubectl get pods/kiada-front-end -n=chp10-set1042 \
-o=custom-columns='CREATED-BY:.metadata.annotations.created-by,MANAGED:.metadata.annotations.managed,REVISION:.metadata.annotations.revision,COMPANY:.metadata.company'
echo $HR

echo "kubectl delete ns chp10-set1042"
kubectl delete ns chp10-set1042

echo $HR_TOP