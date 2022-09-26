#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

echo "In a separate window, run this:"
echo "watch kubectl get pods -l app=quiz -L app -n=chp15-set1525"
enter

kubectl apply -f $FULLPATH/set1525_namespace.yaml
echo ""
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1525 --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/chp15-set1525 --timeout=120s
echo $HR 

echo "kubectl apply -f $FULLPATH/SETUP --recursive"
kubectl apply -f $FULLPATH/SETUP --recursive
echo $HR

kubectl apply -f $FULLPATH/set1525_svc_quiz.yaml
kubectl apply -f $FULLPATH/set1525_statefulset_quiz.yaml
echo $HR 

sleep 3

echo "Wait for Running status phase in pod quiz-0, so we can initiate the MongoDB replica set:"
echo ""
echo "kubectl wait pod/quiz-0 -n=chp15-set1525 --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait pod/quiz-0 -n=chp15-set1525 --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

# echo "kubectl wait pod/quiz-1 -n=chp15-set1525 --for=jsonpath=.status.phase=Running --timeout=60s"
# kubectl wait pod/quiz-1 -n=chp15-set1525 --for=jsonpath=.status.phase=Running --timeout=60s
# echo $HR

# echo "kubectl wait pod/quiz-2 -n=chp15-set1525 --for=jsonpath=.status.phase=Running --timeout=60s"
# kubectl wait pod/quiz-2 -n=chp15-set1525 --for=jsonpath=.status.phase=Running --timeout=60s
# echo $HR

echo "kubectl get pods -l app=quiz -n=chp15-set1525"
kubectl get pods -l app=quiz -n=chp15-set1525
echo $HR

echo "Initiate the MongoDB replica set in its quiz-0/quiz-1/quiz-2 pods, since it started with the --replSet option for replication."
echo "Remember that we also have to list the namespace in the host information:"
echo ""
kubectl exec -it quiz-0 -c mongo -n=chp15-set1525 -- mongosh --eval 'rs.initiate({
  _id: "quiz",
  members: [
    {_id: 0, host: "quiz-0.quiz-pods.chp15-set1525.svc.cluster.local:27017"},
    {_id: 1, host: "quiz-1.quiz-pods.chp15-set1525.svc.cluster.local:27017"},
    {_id: 2, host: "quiz-2.quiz-pods.chp15-set1525.svc.cluster.local:27017"}]})'

echo $HR

echo "Disable MongoDB reminder of FreeMonitoring:"
echo "kubectl exec quiz-0 -c mongo -n=chp15-set1525 -- mongosh kiada --quiet --eval 'db.disableFreeMonitoring()'"
kubectl exec quiz-0 -c mongo -n=chp15-set1525 -- mongosh kiada --quiet --eval 'db.disableFreeMonitoring()'
echo $HR

# echo "kubectl rollout status sts quiz -n=chp15-set1525"
# kubectl rollout status sts quiz -n=chp15-set1525
# echo $HR

# echo "kubectl get pods -l app=quiz -n=chp15-set1525"
# kubectl get pods -l app=quiz -n=chp15-set1525

# echo $HR

echo """
We can see that only a single replica is created when we use the StatefulSet with the OrderedReady policy.
This quiz-api container is not ready because the MongoDB instance running alongside it does not have quorum.
Since the readiness probe defined in the quiz-api container depends on the availability of MongoDB, 
which needs at least 2 pods for quorum, and since the StatefulSet controller doesn't start the next Pod until the
first Pod is ready, the StatefulSet is now stuck in a deadlock
"""

echo "kubectl get pod -l app=quiz -n=chp15-set1525"
kubectl get pod -l app=quiz -n=chp15-set1525
echo $HR 



echo "Use a dedicated pod to import quiz data into the MongoDB store."
echo "When the Pod's container starts, it runs the mongoimport command, which connects to the primary MongoDB replica, and imports the data from the file in the volume. The data is then replicated to the secondary replicas."
echo ""
echo "kubectl apply -f $FULLPATH/set1525_quiz_data_importer.yaml"
kubectl apply -f $FULLPATH/set1525_quiz_data_importer.yaml
echo $HR

# echo "kubectl get pvc -l app=quiz -n=chp15-set1525"
# kubectl get pvc -l app=quiz -n=chp15-set1525
# echo $HR

enter
 
#####


echo "Explore changing the readiness probe in the quiz-api container"
echo ""

echo "kubectl apply -f $FULLPATH/set1525_statefulset_quiz_ordered_ready.yaml"
kubectl apply -f $FULLPATH/set1525_statefulset_quiz_ordered_ready.yaml
echo $HR

echo "kubectl get pod -l app=quiz -n=chp15-set1525"
kubectl get pod -l app=quiz -n=chp15-set1525
echo $HR 

echo "We can see that from the age of the Pod, it is still the same Pod."
echo "Even though we updated the Pod template in the StatefulSet, it has not changed."
echo "This is probably the biggest drawback of using StatefulSets with default Pod management policy OrderedReady."
echo "When you use this policy, the StatefulSet does nothing until the Pod is ready."
echo "If your StatefulSet gets into this state shown here, we have to manually delete the unhealthy pod"

enter 

echo "kubectl delete pod quiz-0 -n=chp15-set1525"
kubectl delete pod quiz-0 -n=chp15-set1525
echo $HR

echo "kubectl rollout status sts quiz -n=chp15-set1525"
kubectl rollout status sts quiz -n=chp15-set1525
echo $HR

enter 

#####

echo "Scaling down a StatefulSet with the OrderedReady policy"
echo ""

echo "kubectl scale sts quiz -n=chp15-set1525 --replicas=1"
kubectl scale sts quiz -n=chp15-set1525 --replicas=1
echo $HR 

echo "kubectl rollout status sts quiz -n=chp15-set1525"
kubectl rollout status sts quiz -n=chp15-set1525
echo $HR

echo "kubectl get pod -l app=quiz -n=chp15-set1525"
kubectl get pod -l app=quiz -n=chp15-set1525

enter


##### Clean-up

enter_delete

echo "kubectl delete ns chp15-set1525"
kubectl delete ns chp15-set1525

echo $HR_TOP