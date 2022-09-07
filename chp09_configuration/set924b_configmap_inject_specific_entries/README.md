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