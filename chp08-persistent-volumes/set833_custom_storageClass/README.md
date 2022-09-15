# 8.3.3 Creating a storage class and provisioning volumes of that class

### Objective

1. Explore using a customized StorageClass object

### Events

```
kubectl get events -n=chp08-set833
LAST SEEN   TYPE     REASON                  OBJECT                                 MESSAGE
45s         Normal   WaitForFirstConsumer    persistentvolumeclaim/quiz-data-fast   waiting for first consumer to be created before binding
32s         Normal   Provisioning            persistentvolumeclaim/quiz-data-fast   External provisioner is provisioning volume for claim "chp08-set833/quiz-data-fast"
30s         Normal   ExternalProvisioning    persistentvolumeclaim/quiz-data-fast   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
27s         Normal   ProvisioningSucceeded   persistentvolumeclaim/quiz-data-fast   Successfully provisioned volume pvc-39804cfa-eb59-4f40-b82b-13330ee98781
25s         Normal   Scheduled               pod/quiz-default                       Successfully assigned chp08-set833/quiz-default to worker1
25s         Normal   Pulled                  pod/quiz-default                       Container image "luksa/quiz-api:0.1" already present on machine
25s         Normal   Created                 pod/quiz-default                       Created container quiz-api
25s         Normal   Started                 pod/quiz-default                       Started container quiz-api
25s         Normal   Pulled                  pod/quiz-default                       Container image "mongo:5" already present on machine
25s         Normal   Created                 pod/quiz-default                       Created container mongo
24s         Normal   Started                 pod/quiz-default                       Started container mongo
```

