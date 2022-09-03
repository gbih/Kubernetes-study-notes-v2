# Study Notes for Kubernetes In Action, v2

## Chapter 8: Persisting data in PersistentVolumes

### Objectives
- Using PersistentVolume objects to represent persistent storage
- Claiming persistent volumes with PersistentVolumeClaim objects
- Dynamic provisioning of persistent volumes
- Using node-local persistent storage

### Notes

https://github.com/canonical/microk8s/issues/2618#issuecomment-931988032

The storage addon (microk8s enable storage) is not meant to be used in multi-node clusters. On a multi-node cluster storage is expected to be provided by an external to k8s service. Maybe you may want to look at openebs [1] for which we also have an addon [2].

[1] https://docs.openebs.io/
[2] https://microk8s.io/docs/addon-openebs