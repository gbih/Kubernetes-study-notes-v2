# 8.3.1 Introducing the StorageClass object

### Objective

1. Work through details of the StorageClass

### Notes

* When creating a claim, you use the storageClassName field to specify which storage class you want.

* StorageClass does not take a namespace. Even if you declare it in a YAML file, when you apply it to create an object, there will not be a `namespace` field included.

* StorageClass objects have no spec or status sections. This is because the object only contains static information. 

* In microk8s clusters, the provisioner of the PV is `microk8s.io/hostpath`.

* A StorageClass object represents a class of storage that can be dynamically provisioned. 

* Each storage class specifies what provisioner to use and the parameters that should be passed to it when provisioning the volume. The user decides which storage class to use for each of their persistent volume claims.