#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

echo "In a separate window, run this:"
echo "kubectl alpha events sts quiz -n=chp15-set1531 -w"
enter

kubectl apply -f $FULLPATH/set1531_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1531 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1531 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

kubectl apply -f $FULLPATH/set1531_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1531_statefulset_quiz_v1.yaml
echo $HR 

sleep 3

echo "Wait for Running status phase in pod quiz-0, so we can initiate the MongoDB replica set:"
echo ""
echo "kubectl wait pod/quiz-0 -n=chp15-set1531 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-0 -n=chp15-set1531 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl wait pod/quiz-1 -n=chp15-set1531 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-1 -n=chp15-set1531 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl wait pod/quiz-2 -n=chp15-set1531 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-2 -n=chp15-set1531 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1531"
kubectl get pods -l app=quiz -n=chp15-set1531
echo $HR

echo "Initiate the MongoDB replica set in its quiz-0/quiz-1/quiz-2 pods, since it started with the --replSet option for replication."
echo "Remember that we also have to list the namespace in the host information:"
echo ""
kubectl exec -it quiz-0 -c mongo -n=chp15-set1531 -- mongosh --quiet --eval 'rs.initiate({
  _id: "quiz",
  members: [
    {_id: 0, host: "quiz-0.quiz-pods.chp15-set1531.svc.cluster.local:27017"},
    {_id: 1, host: "quiz-1.quiz-pods.chp15-set1531.svc.cluster.local:27017"},
    {_id: 2, host: "quiz-2.quiz-pods.chp15-set1531.svc.cluster.local:27017"}]})'

echo $HR

echo "kubectl rollout status sts quiz -n=chp15-set1531"
kubectl rollout status sts quiz -n=chp15-set1531
echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1531"
kubectl get pods -l app=quiz -n=chp15-set1531

echo $HR

echo "Use a dedicated pod to import quiz data into the MongoDB store."
echo "When the Pod's container starts, it runs the mongoimport command, which connects to the primary MongoDB replica, and imports the data from the file in the volume. The data is then replicated to the secondary replicas."
echo ""
echo "kubectl apply -f $FULLPATH/set1531_quiz_data_importer.yaml"
kubectl apply -f $FULLPATH/set1531_quiz_data_importer.yaml

enter
 
#####

echo "Update the quiz-api container in the quiz StatefulSet to version 0.2"
echo "We use RollingUpdate as the update strategy type."
echo ""

echo "kubectl apply -f $FULLPATH/set1531_statefulset_quiz_v2.yaml"
kubectl apply -f $FULLPATH/set1531_statefulset_quiz_v2.yaml
echo $HR 

echo "kubectl rollout status sts quiz -n=chp15-set1531"
kubectl rollout status sts quiz -n=chp15-set1531
echo $HR


echo "kubectl get pods -l app=quiz -L controller-revision-hash,ver -n=chp15-set1531"
kubectl get pods -l app=quiz -L controller-revision-hash,ver -n=chp15-set1531
echo $HR 

echo "Display the revision history:"
echo ""
echo "kubectl rollout history sts quiz -n=chp15-set1531"
kubectl rollout history sts quiz -n=chp15-set1531
echo $HR 

echo "Show list of ControllerRevision objects:"
echo ""
echo "kubectl get controllerrevisions -n=chp15-set1531"
kubectl get controllerrevisions -n=chp15-set1531

##### Clean-up

enter_delete

echo "kubectl delete ns chp15-set1531"
kubectl delete ns chp15-set1531

echo $HR_TOP