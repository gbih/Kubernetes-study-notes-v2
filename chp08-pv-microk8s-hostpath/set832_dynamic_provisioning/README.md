# 8.3.2 Dynamic provisioning using the default storage class

### Objective

1. Explore dynamic provisioning using the default storage class

### Notes

* We don't have to manually provision any PersistentVolumes here.

### Events

We are using openebs-jiva-csi-default as the provisioner. This doesn't seem to work with our microk8s cluster:

```
kubectl get events -n=chp08-set832
LAST SEEN   TYPE      REASON        OBJECT             MESSAGE
105s        Warning   FailedMount   pod/quiz-default   Unable to attach or mount volumes: unmounted volumes=[quiz-data], unattached volumes=[kube-api-access-67d5p quiz-data]: timed out waiting for the condition
49s         Warning   FailedMount   pod/quiz-default   MountVolume.MountDevice failed for volume "pvc-e9157912-2b53-412c-86cb-d6dcb9e94c6f" : rpc error: code = FailedPrecondition desc = Max retry count exceeded, volume: {pvc-e9157912-2b53-412c-86cb-d6dcb9e94c6f} is not ready
```