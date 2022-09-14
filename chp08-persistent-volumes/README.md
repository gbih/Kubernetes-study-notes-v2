# Study Notes for Kubernetes In Action, v2

## Chapter 8: Persisting data in PersistentVolumes

### Objectives
- Using PersistentVolume objects to represent persistent storage
- Claiming persistent volumes with PersistentVolumeClaim objects
- Dynamic provisioning of persistent volumes
- Using node-local persistent storage


### Notes

**Using storage vs openebs to provision PersistentVolumes in microk8s:**

The default StorageClass `microk8s-hostpath` is a hostpath based storage, and designed for a single node MicroK8s.

For multi node clusters, it is recommended to use a different approach, such as openebs, rook (ceph), portworx, etc.


* https://github.com/canonical/microk8s/issues/2618#issuecomment-931988032
* https://github.com/canonical/microk8s/issues/1597

* The storage addon (microk8s enable storage) is not meant to be used in multi-node clusters. 
* On a multi-node cluster storage is expected to be provided by an external to k8s service. 


For latest version of microk8s:

```
microk8s enable openebs
```


For microk8s v1.19:

```
sudo systemctl enable iscsid
microk8s enable community
microk8s enable openebs
```


References:

* https://docs.openebs.io/
* https://microk8s.io/docs/addon-openebs

---

**The openebs addon includes the following StorageClass:**

```
openebs-hostpath
openebs-jiva-default
```

* The openebs-hostpath is recommended when using on a laptop or a single node cluster. 
* Use openebs-jiva-default StorageClass for multi-node cluster.


Note: Using openebs-jiva-default requires having 3 replicas.

Using OpenEBS is as easy as creating a PersistentVolumeClaim.

---

**On a single node MicroK8s:**

When using OpenEBS with a single node MicroK8s, it is recommended to use the openebs-hostpath StorageClass

To create a PersistentVolumeClaim utilizing the openebs-hostpath StorageClass

```
kind: PersistentVolumeClaim 
apiVersion: v1
metadata:
  name: local-hostpath-pvc
spec:
  storageClassName: openebs-hostpath
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5G
```

---

**On a multi node MicroK8s***


```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: jiva-volume-claim
spec:
  storageClassName: openebs-jiva-csi-default
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5G
```

---

To check that openebs-ndm on each node is started correctly:

```
kubectl -n openebs get pods -o wide
```




