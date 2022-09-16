# 9.2.3 Injecting config map values into environmental variables

### Objective

1. Use a config map in a pod.

### Mechanism

To inject a single config map entry into an environmental variable, replace the `value` field in the environment variable definition with the `valueFrom` field and refer to the config map entry.

### Events

```
kubectl get events -n=chp09-set923
LAST SEEN   TYPE     REASON      OBJECT      MESSAGE
7s          Normal   Scheduled   pod/kiada   Successfully assigned chp09-set923/kiada to main
6s          Normal   Pulled      pod/kiada   Container image "georgebaptista/kiada:0.4" already present on machine
6s          Normal   Created     pod/kiada   Created container kiada
6s          Normal   Started     pod/kiada   Started container kiada
```
