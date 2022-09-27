#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

echo "In a separate window, run this:"
echo "watch kubectl get pods -l app=quiz -L ver,controller-revision-hash,ver -n=chp15-set1533"
enter

kubectl apply -f $FULLPATH/set1533_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1533 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1533 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

kubectl apply -f $FULLPATH/set1533_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1553_sts_v1_onDelete.yaml
echo $HR 

sleep 3

echo "Wait for Running status phase in pod quiz-0, so we can initiate the MongoDB replica set:"
echo ""

echo "kubectl wait pod/quiz-0 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-0 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s
echo ""
echo "kubectl wait pod/quiz-1 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-1 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s
echo ""
echo "kubectl wait pod/quiz-2 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-2 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1533"
kubectl get pods -l app=quiz -n=chp15-set1533
echo $HR

echo "Initiate the MongoDB replica set in its quiz-0/quiz-1/quiz-2 pods, since it started with the --replSet option for replication."
echo "Remember that we also have to list the namespace in the host information:"
echo ""
kubectl exec -it quiz-0 -c mongo -n=chp15-set1533 -- mongosh --quiet --eval 'rs.initiate({
  _id: "quiz",
  members: [
    {_id: 0, host: "quiz-0.quiz-pods.chp15-set1533.svc.cluster.local:27017"},
    {_id: 1, host: "quiz-1.quiz-pods.chp15-set1533.svc.cluster.local:27017"},
    {_id: 2, host: "quiz-2.quiz-pods.chp15-set1533.svc.cluster.local:27017"}]})'

echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1533"
kubectl get pods -l app=quiz -n=chp15-set1533

echo $HR

echo "Use a dedicated pod to import quiz data into the MongoDB store."
echo "When the Pod's container starts, it runs the mongoimport command, which connects to the primary MongoDB replica, and imports the data from the file in the volume. The data is then replicated to the secondary replicas."
echo ""
echo "kubectl apply -f $FULLPATH/set1533_quiz_data_importer.yaml"
kubectl apply -f $FULLPATH/set1533_quiz_data_importer.yaml

enter
 
#####

echo "Apply a new manifest for the StatefulSet:"
echo "We use the OnDelete update strategy here."
echo "The rollout is semi-automatic, where we manually delete each Pod, and the StatefulSet controller then creates the replacement Pod with the new template."
echo "In this strategy, we have to decide which Pod to update and when."
echo ""

echo "kubectl apply -f $FULLPATH/set1553_sts_v2_onDelete.yaml"
kubectl apply -f $FULLPATH/set1553_sts_v2_onDelete.yaml
echo $HR 

# echo "kubectl rollout status sts quiz -n=chp15-set1533"
# kubectl rollout status sts quiz -n=chp15-set1533
# echo $HR

echo "kubectl get sts quiz -n=chp15-set1533 -o wide"
kubectl get sts quiz -n=chp15-set1533 -o wide
echo $HR

echo "kubectl get pods -l app=quiz -L controller-revision-hash,ver -n=chp15-set1533"
kubectl get pods -l app=quiz -L controller-revision-hash,ver -n=chp15-set1533
echo $HR 

enter

#####

echo "kubectl delete pod quiz-0 -n=chp15-set1533"
kubectl delete pod quiz-0 -n=chp15-set1533
echo $HR 

echo "kubectl delete pod quiz-2 -n=chp15-set1533"
kubectl delete pod quiz-2 -n=chp15-set1533
echo $HR 

echo "kubectl wait pod/quiz-0 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-0 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s
echo ""
echo "kubectl wait pod/quiz-1 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-1 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s
echo ""
echo "kubectl wait pod/quiz-2 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-2 -n=chp15-set1533 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl get sts quiz -n=chp15-set1533 -o wide"
kubectl get sts quiz -n=chp15-set1533 -o wide
echo $HR

echo "kubectl get pods -l app=quiz -L controller-revision-hash,ver -n=chp15-set1533"
kubectl get pods -l app=quiz -L controller-revision-hash,ver -n=chp15-set1533


##### Clean-up

enter_delete

echo "kubectl delete ns chp15-set1533"
kubectl delete ns chp15-set1533

echo $HR_TOP