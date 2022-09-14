# 8.2.1 Creating a PersistentVolume object

### Objective

1. Build a new service that requires its data to be persisted.
2. The pod that runs the services will contain a volume.

### Notes

* To make pod manifests portable across different cluster environments, the environment-specific information about the actual storage volume is moved to a PersistentVolume (PV) object.
* A PV object represents a storage volume that is used to persist application data.
* The PV object stores the information about the underlying storage and decouples this information from the pod.
* A PersistentVolumeClaim (PVC) object connects the pod to this PV object.
* Because the PVC lifecycle is not tied to that of the pod, it allows the ownership of the PV to be decoupled from the pod. 
* Before a user can use a PV in their pods, they must first claim the volume by creating a PVC object.
* After claiming the volume, the user has exclusive rights to it and can use it in their pods.


### Reference

https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/