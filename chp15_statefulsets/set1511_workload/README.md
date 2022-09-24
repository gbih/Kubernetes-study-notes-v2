# 15.1.1 Understanding stateful workload requirements


### Objective

1. Explore the reasons and implementation of stateful workloads


### Notes

Very useful experimental extensions of `kubectl events`:

Deployment-specific:

```
kubectl alpha events deploy quiz -n=chp15-set1511
```

Pod-specific:

```
kubectl alpha events pod quiz-6cd8f6c4cb-c9f58 -n=chp15-set1511
```

* Reference:
	- https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#alpha