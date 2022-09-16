# 9.5.1 Using projected volumes to combine volumes into one

### Objective

1. Explore how to populate a single volume from multiple sources via the projected volume type.

### Notes

This is similar to `subPath`, but more flexible.

### Events

```
kubectl get events -n=chp09-set951
LAST SEEN   TYPE     REASON      OBJECT          MESSAGE
2s          Normal   Scheduled   pod/kiada-ssl   Successfully assigned chp09-set951/kiada-ssl to main
1s          Normal   Pulled      pod/kiada-ssl   Container image "georgebaptista/kiada:0.4" already present on machine
1s          Normal   Created     pod/kiada-ssl   Created container kiada
1s          Normal   Started     pod/kiada-ssl   Started container kiada
1s          Normal   Pulled      pod/kiada-ssl   Container image "envoyproxy/envoy:v1.14.1" already present on machine
1s          Normal   Created     pod/kiada-ssl   Created container envoy
1s          Normal   Started     pod/kiada-ssl   Started container envoy
```