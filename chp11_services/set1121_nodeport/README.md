# 11.2.1 Exposing pods through a NodePort service


### Objective

1. Make pods accessible to external clients by exposing them through a NodePort service.

### Notes

* When creating a NodePort service, the pods that match its selector are accessible through a specific port on all nodes in the cluster.

* Because the port is open on the nodes, this is called "NodePort".

* Like a ClusterIP service, a NodePort service is accessible through its internal cluster IP, but also through the node port on each of the cluster nodes.

* It doesn't matter which node a client connects to, because all the nodes will forward the connection to a pod that belongs to the service, regardless of which node is running the pod.