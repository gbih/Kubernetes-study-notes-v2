#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

echo "In a separate window, run this:"
echo "watch kubectl alpha events statefulset quiz -n=chp15-set1513"
enter

kubectl apply -f $FULLPATH/set1513_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1513 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1513 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

kubectl apply -f $FULLPATH/set1513_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1513_statefulset_quiz.yaml
echo $HR 

echo "kubectl rollout status sts quiz -n=chp15-set1513 --timeout=10s"
kubectl rollout status sts quiz -n=chp15-set1513 --timeout=10s
echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1513"
kubectl get pods -l app=quiz -n=chp15-set1513
echo $HR

echo "Inspect a single pod from this StatefulSet"
ss_pod=$(kubectl get pods -l statefulset.kubernetes.io/pod-name=quiz-0 -n=chp15-set1513 -o name)
echo $ss_pod
echo $HR


echo "kubectl logs $ss_pod -c quiz-api -n=chp15-set1513 | tail -5"
kubectl logs $ss_pod -c quiz-api -n=chp15-set1513 | tail -5
echo $HR

enter

echo "Need to initiate the MongoDB replica set, since it started with the --replSet option for replication:"
echo "Remember that we also have to list the namespace in the host information:"
echo ""
kubectl exec -it quiz-0 -c mongo -n=chp15-set1513 -- mongosh --quiet --eval 'rs.initiate({
  _id: "quiz",
  members: [
    {_id: 0, host: "quiz-0.quiz-pods.chp15-set1513.svc.cluster.local:27017"},
    {_id: 1, host: "quiz-1.quiz-pods.chp15-set1513.svc.cluster.local:27017"},
    {_id: 2, host: "quiz-2.quiz-pods.chp15-set1513.svc.cluster.local:27017"}]})'


echo $HR

echo "kubectl rollout status sts quiz -n=chp15-set1513"
kubectl rollout status sts quiz -n=chp15-set1513
enter 

echo "kubectl describe sts quiz -n=chp15-set1513"
kubectl describe sts quiz -n=chp15-set1513
enter 

echo "Check the Pod manifest created by the StatefulSet:"
echo ""
echo "kubectl get pod quiz-0 -o yaml -n=chp15-set1513"
kubectl get pod quiz-0 -o yaml -n=chp15-set1513
enter 

echo "Along with the Pods, the StatefulSet create a PVC for each Pod."
echo ""
echo "kubectl get pvc -l app=quiz -n=chp15-set1513 --show-labels"
kubectl get pvc -l app=quiz -n=chp15-set1513 --show-labels

##### Clean-up

enter_delete

echo "kubectl delete ns chp15-set1513"
kubectl delete ns chp15-set1513

echo $HR_TOP