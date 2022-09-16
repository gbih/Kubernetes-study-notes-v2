# 10.1.3 Managing objects in other namespaces

### Objective

1. Create namespaces both imperatively on CLI, and declaratively via YAML manifest file.

### Notes

The book lists this imperative manner:

```
kubectl apply -f kiada-ssl.yaml -n chp10-set1013
```

but it is much clearer to explicitly declare the namespace in the YAML manifest files of the respective Kubernetes objects.

### Events

```
kubectl get events -n=chp10-set1013
LAST SEEN   TYPE     REASON      OBJECT          MESSAGE
3s          Normal   Scheduled   pod/kiada-ssl   Successfully assigned chp10-set1013/kiada-ssl to main
2s          Normal   Pulled      pod/kiada-ssl   Container image "georgebaptista/kiada:0.4" already present on machine
2s          Normal   Created     pod/kiada-ssl   Created container kiada
1s          Normal   Started     pod/kiada-ssl   Started container kiada
1s          Normal   Pulled      pod/kiada-ssl   Container image "envoyproxy/envoy:v1.14.1" already present on machine
1s          Normal   Created     pod/kiada-ssl   Created container envoy
1s          Normal   Started     pod/kiada-ssl   Started container envoy
```