#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

# References this page
# https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/

#####

echo $HR_TOP

echo "View namespaces:"
kubectl get namespace
echo $HR

echo """
Kubernetes starts with four initial namespaces:

* default: The default namespace for objects with no other namespace

* kube-system: The namespace for objects created by the Kubernetes system

* kube-public: This namespace is created automatically and is readable by all users (including those not authenticated). This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement.

* kube-node-lease: This namespace holds Lease objects associated with each node. Node leases allow the kubelet to send heartbeats so that the control plane can detect node failure.
"""

enter

echo "kubectl get all -n=default"
kubectl get all -n=default
enter

echo "kubectl get all -n=kube-system"
kubectl get all -n=kube-system
enter

echo "kubectl get all -n=kube-public"
kubectl get all -n=kube-public
enter

echo "kubectl get all -n=kube-node-lease"
kubectl get all -n=kube-node-lease
enter


echo "View resources in a namespace:"
kubectl api-resources --namespaced=true
enter


echo "View resources not in a namespace:"
kubectl api-resources --namespaced=false

