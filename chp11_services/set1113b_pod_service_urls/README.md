# 11.1.3b Using Services in a Pod


### Objective

1. Deploy the Kiada pods and configure them to use both the Quiz and Quote services.

### Notes


**Using storage vs openebs to provision PersistentVolumes in microk8s:**

https://github.com/canonical/microk8s/issues/2618#issuecomment-931988032

* The storage addon (microk8s enable storage) is not meant to be used in multi-node clusters. 
* On a multi-node cluster storage is expected to be provided by an external to k8s service. 