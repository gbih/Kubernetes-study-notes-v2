#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

echo "kubectl apply -f $FULLPATH/set1541_namespace.yaml"
kubectl apply -f $FULLPATH/set1541_namespace.yaml
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
  rm -r config/samples
else
  echo "Installation files for MongoDB Community Kubernetes Operator downloaded to ./config"
fi

echo $HR 

# For trouble-shooting:
# echo "Check the cluster Node's status and other details before installing the Operator:"
# echo ""
# echo "kubectl describe nodes"
# kubectl describe nodes
# enter


# Same steps as listed here:
# https://github.com/mongodb/mongodb-kubernetes-operator/blob/master/docs/install-upgrade.md#install-the-operator-using-kubectl

echo "1. Create a CustomResourceDefinition object for MongoDB (no namespace):"
echo "kubectl apply -f config/crd/bases/mongodbcommunity.mongodb.com_mongodbcommunity.yaml"
kubectl apply -f config/crd/bases/mongodbcommunity.mongodb.com_mongodbcommunity.yaml
echo ""

echo "Verify that the Custom Resource Definitions installed successfully:"
echo "kubectl get crd mongodbcommunity.mongodbcommunity.mongodb.com"
kubectl get crd mongodbcommunity.mongodbcommunity.mongodb.com
enter


echo "2. Install the necessary roles and role-bindings, in namespace mongodb"
echo "kubectl apply -k config/rbac/ -n mongodb"
kubectl apply -k config/rbac/ -n mongodb
echo ""

echo "Verify that the resources have been created:"
kubectl get role mongodb-kubernetes-operator -n mongodb
echo ""
kubectl get rolebinding mongodb-kubernetes-operator -n mongodb
echo ""
kubectl get serviceaccount mongodb-kubernetes-operator -n mongodb
enter


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


enter_delete

##### Clean-up

echo "Delete the CustomResourceDefinition:"
echo ""
echo "kubectl delete crd mongodbcommunity.mongodbcommunity.mongodb.com"
kubectl delete crd mongodbcommunity.mongodbcommunity.mongodb.com
echo $HR 

echo "Delete the namespace, deployment and rbac-associated objects:"
echo ""
echo "kubectl delete ns mongodb"
kubectl delete ns mongodb

echo $HR_TOP