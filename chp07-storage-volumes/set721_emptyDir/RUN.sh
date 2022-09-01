#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP


echo "kubectl apply -f $FULLPATH/set712_namespace.yaml"
kubectl apply -f $FULLPATH/set712_namespace.yaml
echo $HR

echo "kubectl apply -f $FULLPATH/set712_pod.yaml"
kubectl apply -f $FULLPATH/set712_pod.yaml

echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp07-set712 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp07-set712 --timeout=120s
echo $HR

echo "kubectl get all -n=chp07-set712 -o wide"
kubectl get all -n=chp07-set712 -o wide
echo $HR

enter

echo "Add question to the database"
echo """kubectl exec -i -n=chp07-set712 quiz -c mongo -- mongosh kiada --quiet <<EOF
db.questions.insertOne({
  id: 1,
  text: "What does k8s mean?",
  answers: ["Kates", "Kubernetes", "Kooba Dooba Doo!"],
  correctAnswerIndex: 1
})
EOF
"""

# Create YAML object from stdin
kubectl exec -i -n=chp07-set712 quiz -c mongo -- mongosh kiada --quiet <<EOF
db.questions.insertOne({
  id: 1,
  text: "What does k8s mean?",
  answers: ["Kates", "Kubernetes", "Kooba Dooba Doo!"],
  correctAnswerIndex: 1
})
EOF

enter


echo "Read question from the Mongo DB and the Quiz API"
echo ""
echo 'kubectl exec -n=chp07-set712 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.find()"'
kubectl exec -n=chp07-set712 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.find()"
echo $HR

echo 'kubectl exec -n=chp07-set712 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.countDocuments()"'
kubectl exec -n=chp07-set712 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.countDocuments()"
echo $HR


echo "IP=\$(kubectl get pod -n=chp07-set712 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp07-set712 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR

echo "Retrieve a random question through the Quiz API:"
echo ""
for i in {1..1}
do
	echo "curl $IP:8080/questions/random"
	curl $IP:8080/questions/random
	echo $HR
	sleep 1
done

enter

echo "Restart the Mongo database"
echo 'kubectl exec -n=chp07-set712 quiz -c mongo -- mongosh --quiet admin --eval "db.shutdownServer()"'
kubectl exec -n=chp07-set712 quiz -c mongo -- mongosh --quiet admin --eval "db.shutdownServer()"
echo $HR

sleep 5

echo "When the database shuts down, the container stops, and Kubernetes starts a new one in its place."
echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp07-set712 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp07-set712 --timeout=120s
echo $HR

echo "kubectl get all -n=chp07-set712 -o wide"
kubectl get all -n=chp07-set712 -o wide
echo $HR


echo "Check if questions are still stored:"
echo 'kubectl exec -n=chp07-set712 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.countDocuments()"'
kubectl exec -n=chp07-set712 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.countDocuments()"
echo $HR


echo "Retrieve a random question through the Quiz API:"
echo ""
for i in {1..1}
do
  echo "curl $IP:8080/questions/random"
  curl $IP:8080/questions/random
  echo $HR
  sleep 1
done


echo "Check the unique pod_UID:"
echo "kubectl get pod quiz -n=chp07-set712 -o json | jq .metadata.uid"
kubectl get pod quiz -n=chp07-set712 -o json | jq .metadata.uid
echo $HR


echo "Get the name of the node that runs the pod":
echo "kubectl get pod quiz -n=chp07-set712 -o json | jq .spec.nodeName"
kubectl get pod quiz -n=chp07-set712 -o json | jq .spec.nodeName
enter

echo "Check logs"
echo ""
echo "kubectl logs quiz -c quiz-api -n=chp07-set712"
kubectl logs quiz -c quiz-api -n=chp07-set712
echo $HR


echo "Check events"
echo ""
echo "kubectl get events -n=chp07-set712 | grep -i quiz-api"
kubectl get events -n=chp07-set712 | grep -i quiz-api
echo $HR


echo "kubectl delete ns chp07-set712"
kubectl delete ns chp07-set712

echo $HR_TOP