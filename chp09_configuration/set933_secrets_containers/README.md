# 9.3.3 Using secrets in containers

### Objective

1. Use secrets in containers the same way we use config maps -- use them to set env vars or create files in the container's filesystem.

2. Use a secret volume to project secret entries into files.

### Events

```
kubectl get events -n=chp09-set933
LAST SEEN   TYPE     REASON      OBJECT          MESSAGE
6s          Normal   Scheduled   pod/kiada-ssl   Successfully assigned chp09-set933/kiada-ssl to main
5s          Normal   Pulled      pod/kiada-ssl   Container image "envoyproxy/envoy:v1.14.1" already present on machine
5s          Normal   Created     pod/kiada-ssl   Created container envoy
5s          Normal   Started     pod/kiada-ssl   Started container envoy
5s          Normal   Pulled      pod/kiada-ssl   Container image "georgebaptista/kiada:0.4" already present on machine
5s          Normal   Created     pod/kiada-ssl   Created container kiada
5s          Normal   Started     pod/kiada-ssl   Started container kiada
```