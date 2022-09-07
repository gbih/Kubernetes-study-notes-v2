# 9.2.5 Updating and deleting config maps

### Objective

1. Prevent a config map from being mutated


### Notes

* In theory, it is possible to mutate config maps. However, it is a best practice to treat them as immutable. If there is need for a change, create a new config map and corresponding pod, etc. So, we want to treat config maps as immutable objects

* Immutable config maps prevent users from accidentally changing application configuration, but also help improve the performance of the Kubernetes cluster. When a config map is marked as immutable, the Kubelets on the worker nodes that use it don't have to be notified of changes to the ConfigMap object. This reduces the load on the API server.


### Mechanism

* Use the `immutable: true` key-value pair:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: kiada-config-yaml
  namespace: chp09-set925
data:
  status-message: This status message is set in the kiada-config config map.
immutable: false
```
