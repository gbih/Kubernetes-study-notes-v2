# Extra: microk8s addon - Hostpath Storage

https://discuss.kubernetes.io/t/addon-hostpath-storage/20878

* The hostpath storage MicroK8s add-on can be used to easily provision PersistentVolumes backed by a host directory. It is ideal for local development, but note that PersistentVolumeClaims created by the hostpath storage provisioner are bound to the local node, so it is impossible to move them to a different node.

### Enable

```
microk8s enable hostpath-storage
```

