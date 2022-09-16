# 9.2.3 Injecting config map values into environmental variables

### Objective

1. Use a config map in a pod.

### Notes

This seems much more efficient than listing each individual config map key.

### Mechanism

* To inject a single config map entry into an environmental variable, replace the `value` field in the environment variable definition with the `valueFrom` field and refer to the config map entry.

* In the pod spec definition, definitely use the prefix field, as it makes things much more explicit, as in :

```
envFrom:
- prefix: CONFIG_
  configMapRef:
    name: kiada-config
    optional: true
```

### Events

```
kubectl get events -n=chp09-set923b
LAST SEEN   TYPE     REASON      OBJECT      MESSAGE
4s          Normal   Scheduled   pod/kiada   Successfully assigned chp09-set923b/kiada to main
3s          Normal   Pulled      pod/kiada   Container image "georgebaptista/kiada:0.4" already present on machine
3s          Normal   Created     pod/kiada   Created container kiada
3s          Normal   Started     pod/kiada   Started container kiada
```
