# 10.1.4 Understanding the (lack of) isolation between namespaces

### Objective

1. Understand the runtime isolation between pods in different namespaces.

### Notes

* By default, there is no network isolation between namespaces. 

* Because namespaces don't provide true isolation, you should not use them to split a single physical Kubernetes cluster into the production, staging, and development environments. 

* Hosting each environment on a separate physical cluster is a much safer approach.

### Events

```
kubectl get events -n=chp10-set1014
LAST SEEN   TYPE     REASON      OBJECT          MESSAGE
3s          Normal   Scheduled   pod/kiada-ssl   Successfully assigned chp10-set1014/kiada-ssl to main
2s          Normal   Pulled      pod/kiada-ssl   Container image "georgebaptista/kiada:0.4" already present on machine
2s          Normal   Created     pod/kiada-ssl   Created container kiada
1s          Normal   Started     pod/kiada-ssl   Started container kiada
1s          Normal   Pulled      pod/kiada-ssl   Container image "envoyproxy/envoy:v1.14.1" already present on machine
1s          Normal   Created     pod/kiada-ssl   Created container envoy
1s          Normal   Started     pod/kiada-ssl   Started container envoy
```