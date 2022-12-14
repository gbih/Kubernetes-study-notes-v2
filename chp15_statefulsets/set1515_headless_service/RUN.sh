#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

echo "In a separate window, run this:"
echo "watch kubectl alpha events statefulset quiz -n=chp15-set1515"
enter

kubectl apply -f $FULLPATH/set1515_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1515 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1515 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

kubectl apply -f $FULLPATH/set1515_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1515_statefulset_quiz.yaml
echo $HR 

sleep 3

echo "Wait for Running status phase in pod quiz-0, so we can initiate the MongoDB replica set:"
echo ""
echo "kubectl wait pod/quiz-0 -n=chp15-set1515 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-0 -n=chp15-set1515 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1515"
kubectl get pods -l app=quiz -n=chp15-set1515
echo $HR


enter

echo "Initiate the MongoDB replica set in its quiz-0/quiz-1/quiz-2 pods, since it started with the --replSet option for replication."
echo "Remember that we also have to list the namespace in the host information:"
echo ""
kubectl exec -it quiz-0 -c mongo -n=chp15-set1515 -- mongosh --quiet --eval 'rs.initiate({
  _id: "quiz",
  members: [
    {_id: 0, host: "quiz-0.quiz-pods.chp15-set1515.svc.cluster.local:27017"},
    {_id: 1, host: "quiz-1.quiz-pods.chp15-set1515.svc.cluster.local:27017"},
    {_id: 2, host: "quiz-2.quiz-pods.chp15-set1515.svc.cluster.local:27017"}]})'

echo $HR

echo "kubectl rollout status sts quiz -n=chp15-set1515"
kubectl rollout status sts quiz -n=chp15-set1515
echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1515"
kubectl get pods -l app=quiz -n=chp15-set1515

enter 

echo "Use a dedicated pod to import quiz data into the MongoDB store."
echo "When the Pod's container starts, it runs the mongoimport command, which connects to the primary MongoDB replica, and imports the data from the file in the volume. The data is then replicated to the secondary replicas."
echo ""
echo "kubectl apply -f $FULLPATH/set1515_quiz_data_importer.yaml"
kubectl apply -f $FULLPATH/set1515_quiz_data_importer.yaml
echo $HR

echo "kubectl get pvc -l app=quiz -n=chp15-set1515"
kubectl get pvc -l app=quiz -n=chp15-set1515
echo $HR

echo "kubectl exec quiz-0 -c mongo -n=chp15-set1515 -- mongosh --quiet --eval 'db.questions.find()'"
kubectl exec quiz-0 -c mongo -n=chp15-set1515 -- mongosh --quiet --eval 'db.questions.find()'
 
##### Clean-up

enter_delete

echo "kubectl delete ns chp15-set1515"
kubectl delete ns chp15-set1515

echo $HR_TOP