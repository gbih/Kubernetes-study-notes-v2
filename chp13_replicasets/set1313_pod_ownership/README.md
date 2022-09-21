# 13.1.3 Understanding Pod ownership


### Objective

1. Understand the owner/dependent mechanism of ReplicaSets and Pods created via them.

### Notes

* Kubernetes has a garbage collector that automatically deletes dependent objects when their owner is deleted. 
