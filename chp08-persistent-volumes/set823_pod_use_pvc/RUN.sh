#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

echo "Use a claim and volume in a single pod."

echo $HR

kubectl apply -f $FULLPATH/set823_namespace.yaml
kubectl apply -f $FULLPATH/set823_pod.yaml
kubectl apply -f $FULLPATH/set823_pv_quizdata.yaml
kubectl apply -f $FULLPATH/set823_pv_otherdata.yaml
kubectl apply -f $FULLPATH/set823_pvc.yaml

echo $HR 

echo "Wait for PV quiz-data status to be Available or Bound:"
until kubectl get pv/quiz-data --output=jsonpath='{.status.phase}' | grep -E "Available|Bound"; do : echo "PV Status: " kubectl get pv/quiz-data --output=jsonpath='{.status.phase}'; done
echo $HR 

echo "kubectl get pv -o wide"
kubectl get pv -o wide

enter

echo "Wait for PVC quiz-data status to be Available or Bound:"
until kubectl get pvc/quiz-data -n=chp08-set823 --output=jsonpath='{.status.phase}' | grep -E "Available|Bound"; do : echo "PV Status: " kubectl get pvc/quiz-data -n=chp08-set823 --output=jsonpath='{.status.phase}'; done
echo $HR 


echo "kubectl get pvc/quiz-data -n=chp08-set823"
kubectl get pvc -n=chp08-set823
echo $HR

echo "kubectl describe pvc/quiz-data -n=chp08-set823"
kubectl describe pvc -n=chp08-set823

enter

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp08-set823 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp08-set823 --timeout=120s
echo $HR

echo "kubectl get all -n=chp08-set823 -o wide"
kubectl get all -n=chp08-set823 -o wide
echo $HR

echo "Add question to the database"
echo """kubectl exec -i -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet <<EOF
db.questions.insertOne({
  id: 1,
  text: "What does k8s mean?",
  answers: ["Kates", "Kubernetes", "Kooba Dooba Doo!"],
  correctAnswerIndex: 1
})
EOF
"""

# Create YAML object from stdin
kubectl exec -i -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet <<EOF
db.questions.insertOne({
  id: 1,
  text: "What does k8s mean?",
  answers: ["Kates", "Kubernetes", "Kooba Dooba Doo!"],
  correctAnswerIndex: 1
})
EOF

enter

echo "Read questions from the Mongo DB and the Quiz API"
echo 'kubectl exec -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.find()"'
kubectl exec -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.find()"
echo $HR

echo 'kubectl exec -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.countDocuments()"'
kubectl exec -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.countDocuments()"
echo $HR


echo "IP=\$(kubectl get pod -n=chp08-set823 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp08-set823 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR

echo "retrieve a random question through the Quiz API:"
for i in {1..1}
do
	echo "curl $IP:8080/questions/random"
	curl $IP:8080/questions/random
	echo $HR
	sleep 1
done

enter

echo "Delete the quiz pod"
echo "kubectl delete pod quiz -n=chp08-set823"
kubectl delete pod quiz -n=chp08-set823
echo $HR

echo "Restart the quiz pod"
echo "kubectl apply -f $FULLPATH/set823_pod.yaml"
kubectl apply -f $FULLPATH/set823_pod.yaml
echo $HR 

echo "kubectl wait --for=condition=Ready=True pods/quiz -n=chp08-set823 --timeout=120s"
kubectl wait --for=condition=Ready=True pods/quiz -n=chp08-set823 --timeout=120s
echo $HR

echo "kubectl get all -n=chp08-set823 -o wide"
kubectl get all -n=chp08-set823 -o wide
echo $HR

enter

echo "Verify data still exists in the Mongo DB and the Quiz API"
# echo 'kubectl exec -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.find()"'
# kubectl exec -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.find()"
# echo $HR

echo 'kubectl exec -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.countDocuments()"'
kubectl exec -n=chp08-set823 quiz -c mongo -- mongosh kiada --quiet --eval "db.questions.countDocuments()"
echo $HR

echo "IP=\$(kubectl get pod -n=chp08-set823 -o jsonpath='{.items[0].status.podIP}')"
IP=$(kubectl get pod -n=chp08-set823 -o jsonpath='{.items[0].status.podIP}')
echo $IP
echo $HR

echo "retrieve a random question through the Quiz API:"
for i in {1..1}
do
	echo "curl $IP:8080/questions/random"
	curl $IP:8080/questions/random
	echo $HR
	sleep 1
done

enter

echo "kubectl delete ns chp08-set823"
kubectl delete ns chp08-set823
echo $HR

echo "kubectl delete pv quiz-data --grace-period=10 "
kubectl delete pv quiz-data --grace-period=10
echo $HR

echo "kubectl delete pv other-data --grace-period=10"
kubectl delete pv other-data --grace-period=10 
echo $HR

echo "Check the underlying storage on the worker node:"
echo "ls -la /var/quiz-data"
ls -la /var/quiz-data
echo $HR

echo "Delete this underlying storage"
echo "sudo rm -fr /var/quiz-data"
sudo rm -fr /var/quiz-data

echo $HR_TOP