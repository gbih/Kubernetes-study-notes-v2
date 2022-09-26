#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

echo "In a separate window, run this:"
echo "watch kubectl get pvc -n=chp15-set1524 -l app=quiz -L app"
enter

kubectl apply -f $FULLPATH/set1524_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1524 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1524 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

kubectl apply -f $FULLPATH/set1524_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1524_statefulset_quiz.yaml
echo $HR 

sleep 3

echo "Wait for Running status phase in pod quiz-0, so we can initiate the MongoDB replica set:"
echo ""
echo "kubectl wait pod/quiz-0 -n=chp15-set1524 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-0 -n=chp15-set1524 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl wait pod/quiz-1 -n=chp15-set1524 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-1 -n=chp15-set1524 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl wait pod/quiz-2 -n=chp15-set1524 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-2 -n=chp15-set1524 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1524"
kubectl get pods -l app=quiz -n=chp15-set1524
echo $HR

echo "Initiate the MongoDB replica set in its quiz-0/quiz-1/quiz-2 pods, since it started with the --replSet option for replication."
echo "Remember that we also have to list the namespace in the host information:"
echo ""
kubectl exec -it quiz-0 -c mongo -n=chp15-set1524 -- mongosh --eval 'rs.initiate({
  _id: "quiz",
  members: [
    {_id: 0, host: "quiz-0.quiz-pods.chp15-set1524.svc.cluster.local:27017"},
    {_id: 1, host: "quiz-1.quiz-pods.chp15-set1524.svc.cluster.local:27017"},
    {_id: 2, host: "quiz-2.quiz-pods.chp15-set1524.svc.cluster.local:27017"}]})'

echo $HR

echo "Disable MongoDB reminder of FreeMonitoring:"
echo "kubectl exec quiz-0 -c mongo -n=chp15-set1524 -- mongosh kiada --quiet --eval 'db.disableFreeMonitoring()'"
kubectl exec quiz-0 -c mongo -n=chp15-set1524 -- mongosh kiada --quiet --eval 'db.disableFreeMonitoring()'
echo $HR

echo "kubectl rollout status sts quiz -n=chp15-set1524"
kubectl rollout status sts quiz -n=chp15-set1524
echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1524"
kubectl get pods -l app=quiz -n=chp15-set1524

echo $HR

echo "Use a dedicated pod to import quiz data into the MongoDB store."
echo "When the Pod's container starts, it runs the mongoimport command, which connects to the primary MongoDB replica, and imports the data from the file in the volume. The data is then replicated to the secondary replicas."
echo ""
echo "kubectl apply -f $FULLPATH/set1524_quiz_data_importer.yaml"
kubectl apply -f $FULLPATH/set1524_quiz_data_importer.yaml
echo $HR

echo "kubectl get pvc -l app=quiz -n=chp15-set1524"
kubectl get pvc -l app=quiz -n=chp15-set1524
echo $HR

enter
 
#####

echo "Scale up the quiz StatefulSet to 5 replicas:"
echo "We expect the mongo container in 2 pods will not be ready, because they have not yet been added to the MongoDB replica set."
echo ""

echo "kubectl scale sts quiz -n=chp15-set1524 --replicas=5"
kubectl scale sts quiz -n=chp15-set1524 --replicas=5
echo $HR 

echo "kubectl rollout status sts quiz -n=chp15-set1524 --timeout 10s"
kubectl rollout status sts quiz -n=chp15-set1524 --timeout 10s
echo $HR

echo "kubectl get pod -l app=quiz -n=chp15-set1524"
kubectl get pod -l app=quiz -n=chp15-set1524
echo $HR 

echo "kubectl get pvc -l app=quiz -n=chp15-set1524"
kubectl get pvc -l app=quiz -n=chp15-set1524
echo $HR 

echo "kubectl get endpoints -l app=quiz -n=chp15-set1524"
kubectl get endpoints -l app=quiz -n=chp15-set1524

enter 

#####

echo "Scale down the quiz StatefulSet to 3 replicas:"
echo "There should two pods in unhealthy state."
echo "By setting 'persistentVolumeClaimRetentionPolicy.whenScaled: Delete', these two unhealthy pods should automatically be deleted."
echo ""

echo "kubectl scale sts quiz -n=chp15-set1524 --replicas=3"
kubectl scale sts quiz -n=chp15-set1524 --replicas=3
echo $HR 

echo "kubectl rollout status sts quiz -n=chp15-set1524 --timeout 10s"
kubectl rollout status sts quiz -n=chp15-set1524 --timeout 10s
echo $HR

echo "kubectl get pod -l app=quiz -n=chp15-set1524"
kubectl get pod -l app=quiz -n=chp15-set1524
echo $HR 

echo "kubectl get pvc -l app=quiz -n=chp15-set1524"
kubectl get pvc -l app=quiz -n=chp15-set1524
echo $HR 

##### Clean-up

enter_delete

echo "kubectl delete ns chp15-set1524"
kubectl delete ns chp15-set1524

echo $HR_TOP