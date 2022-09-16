# 9.1.2 Setting environment variables in a container

### Objective

1. Set environment variables for each of the pod's containers.

### Events

```
kubectl get events -n=chp09-set912
LAST SEEN   TYPE     REASON      OBJECT                            MESSAGE
12s         Normal   Scheduled   pod/kiada                         Successfully assigned chp09-set912/kiada to main
11s         Normal   Pulled      pod/kiada                         Container image "georgebaptista/kiada:0.4" already present on machine
11s         Normal   Created     pod/kiada                         Created container kiada
11s         Normal   Started     pod/kiada                         Started container kiada
7s          Normal   Scheduled   pod/env-var-references-in-shell   Successfully assigned chp09-set912/env-var-references-in-shell to main
7s          Normal   Pulling     pod/env-var-references-in-shell   Pulling image "alpine"
2s          Normal   Pulled      pod/env-var-references-in-shell   Successfully pulled image "alpine" in 4.727180259s
2s          Normal   Created     pod/env-var-references-in-shell   Created container main
2s          Normal   Started     pod/env-var-references-in-shell   Started container main
```