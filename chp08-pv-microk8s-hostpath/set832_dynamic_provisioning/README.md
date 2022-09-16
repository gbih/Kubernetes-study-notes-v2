# 8.3.2 Dynamic provisioning using the default storage class

### Objective

1. Explore dynamic provisioning using the default storage class

### Notes

* We don't have to manually provision any PersistentVolumes here.

### Events

```
kubectl get events -n=chp08-set832
LAST SEEN   TYPE     REASON                  OBJECT                                    MESSAGE
23s         Normal   WaitForFirstConsumer    persistentvolumeclaim/quiz-data-default   waiting for first consumer to be created before binding
16s         Normal   Provisioning            persistentvolumeclaim/quiz-data-default   External provisioner is provisioning volume for claim "chp08-set832/quiz-data-default"
16s         Normal   ExternalProvisioning    persistentvolumeclaim/quiz-data-default   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
10s         Normal   ProvisioningSucceeded   persistentvolumeclaim/quiz-data-default   Successfully provisioned volume pvc-48f5d6e4-7550-4867-8237-49d72dc4d482
9s          Normal   Scheduled               pod/quiz-default                          Successfully assigned chp08-set832/quiz-default to worker1
8s          Normal   Pulled                  pod/quiz-default                          Container image "georgebaptista/quiz-api:0.1" already present on machine
8s          Normal   Created                 pod/quiz-default                          Created container quiz-api
7s          Normal   Started                 pod/quiz-default                          Started container quiz-api
7s          Normal   Pulled                  pod/quiz-default                          Container image "mongo:5" already present on machine
7s          Normal   Created                 pod/quiz-default                          Created container mongo
7s          Normal   Started                 pod/quiz-default                          Started container mongo
```