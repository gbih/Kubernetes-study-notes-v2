# 8.3.3 Creating a storage class and provisioning volumes of that class

### Objective

1. Explore using a customized StorageClass object

### Events

```
kubectl get events -n=chp08-set833
LAST SEEN   TYPE     REASON                  OBJECT                                 MESSAGE
43s         Normal   WaitForFirstConsumer    persistentvolumeclaim/quiz-data-fast   waiting for first consumer to be created before binding
33s         Normal   Provisioning            persistentvolumeclaim/quiz-data-fast   External provisioner is provisioning volume for claim "chp08-set833/quiz-data-fast"
28s         Normal   ExternalProvisioning    persistentvolumeclaim/quiz-data-fast   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
23s         Normal   ProvisioningSucceeded   persistentvolumeclaim/quiz-data-fast   Successfully provisioned volume pvc-22122e68-ce1b-4704-b4a3-227ff985d863
22s         Normal   Scheduled               pod/quiz-default                       Successfully assigned chp08-set833/quiz-default to worker1
21s         Normal   Pulled                  pod/quiz-default                       Container image "luksa/quiz-api:0.1" already present on machine
21s         Normal   Created                 pod/quiz-default                       Created container quiz-api
21s         Normal   Started                 pod/quiz-default                       Started container quiz-api
21s         Normal   Pulled                  pod/quiz-default                       Container image "mongo:5" already present on machine
21s         Normal   Created                 pod/quiz-default                       Created container mongo
20s         Normal   Started                 pod/quiz-default                       Started container mongo
```

