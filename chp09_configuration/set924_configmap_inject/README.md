# 9.2.4 Injecting config map entries into containers as files

### Objective

1. Inject a configmap into a container via the special `configMap` volume type.

### Notes

* The amount of information that can fit in a config map is limited by etcd. For now, the max size is around 1MB.

* A `configMap` volume makes the config map entries available as individual files. 

### Events

```
kubectl get events -n=chp09-set924
LAST SEEN   TYPE     REASON      OBJECT          MESSAGE
6s          Normal   Scheduled   pod/kiada-ssl   Successfully assigned chp09-set924/kiada-ssl to main
5s          Normal   Pulled      pod/kiada-ssl   Container image "georgebaptista/kiada:0.4" already present on machine
5s          Normal   Created     pod/kiada-ssl   Created container kiada
4s          Normal   Started     pod/kiada-ssl   Started container kiada
4s          Normal   Pulled      pod/kiada-ssl   Container image "luksa/kiada-ssl-proxy:0.1" already present on machine
4s          Normal   Created     pod/kiada-ssl   Created container envoy
4s          Normal   Started     pod/kiada-ssl   Started container envoy
```