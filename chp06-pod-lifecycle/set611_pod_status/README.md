# 6.1.1 Understanding the pod phase

## Objectives
1. Explore the phases a pod can be in

---

## Notes

1. PodScheduled
	- Indicates whether or not the pod has been scheduled to a node. 
2. Initialized
	- The pod's init containers have all completed successfully.
3. ContainersReady
	- All containers in the pod indicate that they are ready. This is a necessary but not sufficient condition for the entire pod to be ready.
4. Ready
	- The pod is ready to provide services to its clients. The containers in the pod and the pod's readiness gates are all reporting that they are ready.