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
