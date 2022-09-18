# 11.4.3 Creating a CNAME alias for an existing service


### Objective

1. Add CNAME records to the cluster DNS. 

### Notes

* In Kubernetes, we add CNAME record to DNS by creating a Service object.

* For some reason, `internalTrafficPolicy: Local` only works on a microk8s cluster when `ha-cluster` is disabled.