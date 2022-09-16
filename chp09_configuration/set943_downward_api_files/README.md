# 9.4.3 Using a downwardAPI volume to expose pod metadata as files

### Objective

1. Explore the Downward API to project pod metadata as files into the container's filesystem using the `downwardAPI` volume type.

### Notes

This is similar to projecting config maps and secrets as files into the container's filesystem, except we use the `downwardAPI` here.

### Events

```
kubectl get events -n=chp09-set943
LAST SEEN   TYPE     REASON      OBJECT          MESSAGE
6s          Normal   Scheduled   pod/kiada-ssl   Successfully assigned chp09-set943/kiada-ssl to main
5s          Normal   Pulled      pod/kiada-ssl   Container image "georgebaptista/kiada:0.4" already present on machine
5s          Normal   Created     pod/kiada-ssl   Created container kiada
5s          Normal   Started     pod/kiada-ssl   Started container kiada
5s          Normal   Pulled      pod/kiada-ssl   Container image "envoyproxy/envoy:v1.14.1" already present on machine
5s          Normal   Created     pod/kiada-ssl   Created container envoy
4s          Normal   Started     pod/kiada-ssl   Started container envoy
```