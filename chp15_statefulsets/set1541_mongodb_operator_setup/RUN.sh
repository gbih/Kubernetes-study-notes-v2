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

echo "Create a CustomResourceDefinition object for MongoDB:"
kubectl apply -f config/crd/bases/mongodbcommunity.mongodb.com_mongodbcommunity.yaml
echo $HR 

echo "Create security-related objects via RBAC manifest files, in the mongodb namespace:"
kubectl apply -k config/rbac/ -n mongodb
echo $HR 

echo "Install the Operator:"
kubectl create -f config/manager/manager.yaml -n mongodb
enter 

#####

echo "Examine created  MongoDB CRD-related objects:"
echo "kubectl get crd mongodbcommunity.mongodbcommunity.mongodb.com"
kubectl get crd mongodbcommunity.mongodbcommunity.mongodb.com
echo $HR

echo "kubectl get all -n=mongodb"
kubectl get all -n=mongodb
echo $HR 

echo "Examine security-related RBAC objects:"
echo "kubectl get role -n mongodb"
kubectl get role -n mongodb
echo ""
echo "kubectl get rolebinding -n mongodb -o wide"
kubectl get rolebinding -n mongodb -o wide
echo ""
echo "kubectl get serviceaccount -n mongodb"
kubectl get serviceaccount -n mongodb
echo $HR 

##### Clean-up

echo "Clean-up:"
echo ""
echo "Usually we delete the namespace created specifically per set, but since we want to use the MongoDB operator later, we will leave this 'mongodb' namespace and the objects created within it running"
echo $HR_TOP