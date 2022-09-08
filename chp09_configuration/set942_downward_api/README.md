# 9.4.2 Injecting pod metadata into environment variables

### Objective

1. Explore the Downward API

### Notes

This is a way to inject values from the pod's metadata, spec, or status fields down into the container. 

### Mechanism

* Use the Downward API to source the value from the pod object itself, by using either the `fieldRef` or the `resourceFieldRef` field, depending on what information you want to inject. 

* `fieldRef` is used to refer to the pod's general metadata.

* `resourceFieldRef` is used to refer to the container's compute resource constraints.

### Reference

* https://kubernetes.io/docs/concepts/workloads/pods/downward-api/
* https://kubernetes.io/docs/tasks/inject-data-application/environment-variable-expose-pod-information/