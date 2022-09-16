# 8.3.4 Resizing persistent volumes

### Objective

1. Explore how to resize persistent volumes
2. Apparently neither microk8s-hostpath nor openebs-hostpath StorageClass is capable of expanding the persistent volume.


### Notes

* Requesting a different volume size does not work with the microk8s provisioner. We get this error message: 

``Ignoring the PVC: didn't find a plugin capable of expanding the volume; waiting for an external controller to process this PVC.
``

### To-do

* Find a provisioner that allows expanding the persistent volume.


### Events

```
kubectl get events -n=chp08-set834
LAST SEEN   TYPE      REASON                  OBJECT                                    MESSAGE
76s         Normal    WaitForFirstConsumer    persistentvolumeclaim/quiz-data-default   waiting for first consumer to be created before binding
75s         Normal    Provisioning            persistentvolumeclaim/quiz-data-default   External provisioner is provisioning volume for claim "chp08-set834/quiz-data-default"
73s         Normal    ExternalProvisioning    persistentvolumeclaim/quiz-data-default   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
70s         Normal    ProvisioningSucceeded   persistentvolumeclaim/quiz-data-default   Successfully provisioned volume pvc-167a31fb-5f5c-4eca-9345-9d0c9764d0ba
69s         Normal    Scheduled               pod/quiz-default                          Successfully assigned chp08-set834/quiz-default to worker1
68s         Normal    Pulled                  pod/quiz-default                          Container image "georgebaptista/quiz-api:0.1" already present on machine
68s         Normal    Created                 pod/quiz-default                          Created container quiz-api
68s         Normal    Started                 pod/quiz-default                          Started container quiz-api
68s         Normal    Pulled                  pod/quiz-default                          Container image "mongo:5" already present on machine
68s         Normal    Created                 pod/quiz-default                          Created container mongo
68s         Normal    Started                 pod/quiz-default                          Started container mongo
65s         Warning   ExternalExpanding       persistentvolumeclaim/quiz-data-default   Ignoring the PVC: didn't find a plugin capable of expanding the volume; waiting for an external controller to process this PVC.
```