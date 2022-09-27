#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

echo $HR_TOP

##### Set-up

kubectl apply -f $FULLPATH/set1541_namespace.yaml
echo ""
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

# Same steps as listed here:
# https://github.com/mongodb/mongodb-kubernetes-operator/blob/master/docs/install-upgrade.md#install-the-operator-using-kubectl

echo "1. Create a CustomResourceDefinition object for MongoDB:"
kubectl apply -f config/crd/bases/mongodbcommunity.mongodb.com_mongodbcommunity.yaml
echo ""

echo "Verify that the Custom Resource Definitions installed successfully:"
kubectl get crd/mongodbcommunity.mongodbcommunity.mongodb.com
echo $HR


echo "2. Install the necessary roles and role-bindings, in namespace mongodb"
kubectl apply -k config/rbac/ -n mongodb
echo ""

echo "Verify that the resources have been created:"
kubectl get role mongodb-kubernetes-operator -n mongodb
echo ""
kubectl get rolebinding mongodb-kubernetes-operator  -n mongodb
echo ""
kubectl get serviceaccount mongodb-kubernetes-operator  -n mongodb
echo $HR 


echo "3. Install the Operator:"
kubectl create -f config/manager/manager.yaml -n mongodb
echo ""

echo "Verify that the Operator installed successsfully:"
kubectl get pods -n mongodb
echo $HR


##### Clean-up

echo "Clean-up:"
echo ""
echo "Usually we delete the namespace created specifically per set, but since we want to use the MongoDB operator later, we will leave this 'mongodb' namespace and the objects created within it running."

echo ""
echo "kubectl get ns mongodb"
kubectl get ns mongodb

echo $HR_TOP