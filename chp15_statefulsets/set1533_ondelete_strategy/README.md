# 15.3.2 RollingUpdate with partition

### Objective

1. Learn how to "pause" StatefulSets with the partition parameter.

### Notes

* We can create pseudo-Canary deployments with this technique.

* rollout status is only available for RollingUpdate strategy type.

* Possible bug:
	- https://github.com/kubernetes/kubernetes/issues/100151#issuecomment-801073848
  	- Necessary to have the client explicitly clear the updateStrategy.rollingUpdate field, as in :

```  
updateStrategy:
	type: OnDelete
	rollingUpdate: null
```