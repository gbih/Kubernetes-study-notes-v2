# 13.3.1 Introducing the reconciliation control loop


### Objective

1. Explore the operation of the ReplicaSet controller

### Notes

* The ReplicaSet controller's reconciliation control loop consists of observing ReplicaSets and Pods.

* Each time a ReplicaSet or Pods changes, the controller checks the list of Pods associated with the ReplicaSet and ensures the actual number of Pods matches the desired number specified in the ReplicaSet. 