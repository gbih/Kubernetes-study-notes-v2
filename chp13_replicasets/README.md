# Study Notes for Kubernetes In Action, v2

## Chapter 13: Replicating Pods with ReplicaSets

### Objectives

* Replicate Pods with the ReplicaSet object
* Keep Pods running when cluster nodes fail
* Explore the reconciliation control loop in Kubernetes controllers
* Explore the API Object ownership and garbage collection

### Notes

To understand the Deployment object, we first have to study ReplicaSets, since they are the object underlying the former.