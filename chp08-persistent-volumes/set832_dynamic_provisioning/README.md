# 8.3.2 Dynamic provisioning using the default storage class

### Objective

1. Explore dynamic provisioning using the default storage class

### Notes

* We don't have to manually provision any PersistentVolumes here.

* In a microk8s cluster, the persistent volume claim we create here is not bound immediately, and its status is Pending.

* Here, our claim will remain in the Pending state until we create a pod that uses this claim.