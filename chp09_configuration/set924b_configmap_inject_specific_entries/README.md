# 9.2.4b Project only specific config map entries

### Objective

1. Specifying which config map entries to include into a configMap volume

### Mechanism

* Use `items` field to list which config map entry should be included in the volume

```
spec:
  volumes:
  # Definition of the configMap volume
  - name: envoy-config
    configMap:
      name: kiada-envoy-config
      # Specifying which config map entries to include into a configMap volume
      items:
      - key: envoy.yaml
        path: envoy.yaml

```

### Events

```
kubectl get events -n=chp09-set924b
LAST SEEN   TYPE     REASON      OBJECT          MESSAGE
7s          Normal   Scheduled   pod/kiada-ssl   Successfully assigned chp09-set924b/kiada-ssl to main
7s          Normal   Pulling     pod/kiada-ssl   Pulling image "luksa/kiada:0.4"
5s          Normal   Pulled      pod/kiada-ssl   Successfully pulled image "luksa/kiada:0.4" in 1.933906082s
5s          Normal   Created     pod/kiada-ssl   Created container kiada
5s          Normal   Started     pod/kiada-ssl   Started container kiada
5s          Normal   Pulling     pod/kiada-ssl   Pulling image "luksa/kiada-ssl-proxy:0.1"
3s          Normal   Pulled      pod/kiada-ssl   Successfully pulled image "luksa/kiada-ssl-proxy:0.1" in 1.823888534s
3s          Normal   Created     pod/kiada-ssl   Created container envoy
3s          Normal   Started     pod/kiada-ssl   Started container envoy
```