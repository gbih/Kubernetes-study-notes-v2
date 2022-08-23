# 3.3.3 Horizontally scaling the application

## Objectives
1. Create additional application instances to further distribute the load
2. Use syntax `kubectl scale deployment kiada --replicas=3 -n=chp03-set333`
3. Expore the `kubectl wait` command, eg
	* `kubectl wait --for=condition=available --timeout=60s --all deployments -n=chp03-set333`
	* `kubectl wait --for=condition=ready  --timeout=60s pod -l app=kiada -n=chp03-set333`
---

## Notes

1. This illustrates the declarative model of Kubernetes
2. We declare the desired state (we want 3 replicas)
3. We leave it up to Kubernetes to implement this desired state