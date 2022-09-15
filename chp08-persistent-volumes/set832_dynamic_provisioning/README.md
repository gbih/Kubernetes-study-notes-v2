# 8.3.2 Dynamic provisioning using the default storage class

### Objective

1. Explore dynamic provisioning using the default storage class

### Notes

* We don't have to manually provision any PersistentVolumes here.

### Events

```
kubectl get events -n=chp08-set832
LAST SEEN   TYPE     REASON                  OBJECT                                    MESSAGE
50s         Normal   WaitForFirstConsumer    persistentvolumeclaim/quiz-data-default   waiting for first consumer to be created before binding
43s         Normal   Provisioning            persistentvolumeclaim/quiz-data-default   External provisioner is provisioning volume for claim "chp08-set832/quiz-data-default"
35s         Normal   ExternalProvisioning    persistentvolumeclaim/quiz-data-default   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
32s         Normal   ProvisioningSucceeded   persistentvolumeclaim/quiz-data-default   Successfully provisioned volume pvc-6a06d8e1-a339-4f38-b00c-da9554a2cbc7
31s         Normal   Scheduled               pod/quiz-default                          Successfully assigned chp08-set832/quiz-default to worker1
29s         Normal   Pulled                  pod/quiz-default                          Container image "luksa/quiz-api:0.1" already present on machine
29s         Normal   Created                 pod/quiz-default                          Created container quiz-api
29s         Normal   Started                 pod/quiz-default                          Started container quiz-api
29s         Normal   Pulled                  pod/quiz-default                          Container image "mongo:5" already present on machine
29s         Normal   Created                 pod/quiz-default                          Created container mongo
28s         Normal   Started                 pod/quiz-default                          Started container mongo
```