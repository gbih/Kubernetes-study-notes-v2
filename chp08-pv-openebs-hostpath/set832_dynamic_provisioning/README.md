# 8.3.2 Dynamic provisioning using the default storage class

### Objective

1. Explore dynamic provisioning using the default storage class

### Notes

* We don't have to manually provision any PersistentVolumes here.

### Events

```
kubectl get events -n=chp08-set832
LAST SEEN   TYPE     REASON                  OBJECT                                    MESSAGE
94s         Normal   WaitForFirstConsumer    persistentvolumeclaim/quiz-data-default   waiting for first consumer to be created before binding
87s         Normal   Provisioning            persistentvolumeclaim/quiz-data-default   External provisioner is provisioning volume for claim "chp08-set832/quiz-data-default"
85s         Normal   ExternalProvisioning    persistentvolumeclaim/quiz-data-default   waiting for a volume to be created, either by external provisioner "openebs.io/local" or manually created by system administrator
82s         Normal   ProvisioningSucceeded   persistentvolumeclaim/quiz-data-default   Successfully provisioned volume pvc-ed67a418-7f3d-40eb-911c-263233fc2189
80s         Normal   Scheduled               pod/quiz-default                          Successfully assigned chp08-set832/quiz-default to main
80s         Normal   Pulling                 pod/quiz-default                          Pulling image "georgebaptista/quiz-api:0.1"
73s         Normal   Pulled                  pod/quiz-default                          Successfully pulled image "georgebaptista/quiz-api:0.1" in 7.149640502s
73s         Normal   Created                 pod/quiz-default                          Created container quiz-api
73s         Normal   Started                 pod/quiz-default                          Started container quiz-api
73s         Normal   Pulling                 pod/quiz-default                          Pulling image "mongo:5"
25s         Normal   Pulled                  pod/quiz-default                          Successfully pulled image "mongo:5" in 47.233550297s
25s         Normal   Created                 pod/quiz-default                          Created container mongo
25s         Normal   Started                 pod/quiz-default                          Started container mongo
```