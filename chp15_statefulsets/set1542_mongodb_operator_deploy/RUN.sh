#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

# For trouble-shooting:
# echo "Check the cluster Node's status and other details before installing the Operator:"
# echo ""
# echo "kubectl describe nodes"
# kubectl describe nodes
# enter

# https://github.com/mongodb/mongodb-kubernetes-operator/blob/master/docs/deploy-configure.md

echo "In a separate container, run this:"
echo "watch kubectl top pods -l app=mongodb-specify-pod-resources-svc -n mongodb"
enter

echo "kubectl apply -f $FULLPATH/set1542_namespace.yaml"
kubectl apply -f $FULLPATH/set1542_namespace.yaml
echo "kubectl wait --for=jsonpath=.status.phase=Active ns/mongodb --timeout=120s"
kubectl wait --for=jsonpath=.status.phase=Active ns/mongodb --timeout=120s
echo $HR 

if [ ! -d config ] # Use -d option to check for directories
then
  echo "Getting the git repository for MongoDB Community Kubernetes Operator"
  git clone https://github.com/mongodb/mongodb-kubernetes-operator.git
  echo "Move the files needed for installation, then delete the repo"
  cp -r mongodb-kubernetes-operator/config ./config
  rm -r mongodb-kubernetes-operator
  # Clean up unnecesary files in ./config
  rm -r config/default
  rm -r config/local_run
else
  echo "Installation files for MongoDB Community Kubernetes Operator downloaded to ./config"
fi

echo $HR 

echo "Deploy the MongoDB community operator:"
echo ""

echo "1. Create a CustomResourceDefinition object for MongoDB (no namespace):"
echo "kubectl apply -f config/crd/bases/mongodbcommunity.mongodb.com_mongodbcommunity.yaml"
kubectl apply -f config/crd/bases/mongodbcommunity.mongodb.com_mongodbcommunity.yaml
echo ""

echo "2. Install the necessary roles and role-bindings, in namespace mongodb"
echo "kubectl apply -k config/rbac/ -n mongodb"
kubectl apply -k config/rbac/ -n mongodb
echo ""

echo "3. Install the Deployment for the MongoDB Operator:"
echo "kubectl apply -f config/manager/manager.yaml -n mongodb"
kubectl apply -f config/manager/manager.yaml -n mongodb
echo ""

mongodb_pod=$(kubectl get pods -n mongodb -o name)
echo "Verify that the Operator installed successsfully:"
echo "kubectl wait $mongodb_pod -n=mongodb --for=jsonpath=.status.phase=Running --timeout=60s"
kubectl wait $mongodb_pod -n=mongodb --for=jsonpath=.status.phase=Running --timeout=60s
echo $HR

echo "kubectl get all -n=mongodb"
kubectl get all -n=mongodb

enter

#####

echo "Deploy MongoDB via the operator:"
echo ""

# The book is missing the namespace tag, which will probably result in an error.

echo "kubectl apply -f $FULLPATH/secret.yaml"
kubectl apply -f $FULLPATH/secret.yaml
echo $HR

echo "Create MongoDBCommunity with 3 replicas:"
echo ""
echo "kubectl apply -f $FULLPATH/mongodb.com_v1_mongodbcommunity_specify_pod_resources_3.yaml"
kubectl apply -f $FULLPATH/mongodb.com_v1_mongodbcommunity_specify_pod_resources_3.yaml
echo $HR

echo "Verify that the MongoDBCommunity resource deployed:"
echo ""
echo "kubectl get mongodbcommunity -n mongodb"
kubectl get mongodbcommunity -n mongodb
echo $HR

echo "Monitor pod status. 3 Pods should start up. Hit Ctrl-C to escape and continue:"
echo ""
echo "kubectl get pods -l app=mongodb-specify-pod-resources-svc -n mongodb -L app -w"
echo ""
kubectl get pods -l app=mongodb-specify-pod-resources-svc -n mongodb -L app -w
echo ""
echo $HR

echo "Objects created by the mongodb StatefulSet controllers:"
echo ""
echo "kubectl get all -l app=mongodb-specify-pod-resources-svc -n mongodb -L app"
kubectl get all -l app=mongodb-specify-pod-resources-svc -n mongodb -L app
enter

echo "We cannot scale via the StatefulSet, such as 'kubectl scale sts example-mongodb -n mongodb --replicas 1'"
echo "Instead, we have to declare the number of replicas in the MongoDBCommunity YAML manifest."
echo ""
echo "Scale MongoDBCommunity down to 1 replicas:"
echo ""
echo "kubectl apply -f $FULLPATH/mongodb.com_v1_mongodbcommunity_specify_pod_resources_1.yaml"
kubectl apply -f $FULLPATH/mongodb.com_v1_mongodbcommunity_specify_pod_resources_1.yaml
echo $HR

echo "Monitor pod status. Hit Ctrl-C to escape and continue:"
echo ""
echo "kubectl get pods -l app=mongodb-specify-pod-resources-svc -n mongodb -L app -w"
echo ""
kubectl get pods -l app=mongodb-specify-pod-resources-svc -n mongodb -L app -w

enter_delete 

##### Clean-up

echo "Delete the CustomResourceDefinition:"
echo ""
echo "kubectl delete crd mongodbcommunity.mongodbcommunity.mongodb.com"
kubectl delete crd mongodbcommunity.mongodbcommunity.mongodb.com
echo $HR 

echo "Delete the namespace, MongoDBCommunity object, and rbac-associated objects:"
echo ""
echo "kubectl delete ns mongodb"
kubectl delete ns mongodb

echo $HR_TOP