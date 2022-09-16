# 11.1.3 Accessing cluster-internal services


### Objective

1. Access ClusterIP services, which are cluster-internal services.

### Events

```
kubectl get events -n=chp11-set1113
LAST SEEN   TYPE      REASON                  OBJECT                            MESSAGE
49s         Warning   FailedScheduling        pod/quiz                          0/2 nodes are available: 2 persistentvolumeclaim "quiz-data" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
49s         Normal    WaitForPodScheduled     persistentvolumeclaim/quiz-data   waiting for pod quiz to be scheduled
48s         Normal    Provisioning            persistentvolumeclaim/quiz-data   External provisioner is provisioning volume for claim "chp11-set1113/quiz-data"
47s         Normal    Scheduled               pod/quote-001                     Successfully assigned chp11-set1113/quote-001 to worker1
47s         Normal    Scheduled               pod/quote-002                     Successfully assigned chp11-set1113/quote-002 to worker1
47s         Normal    Scheduled               pod/quote-003                     Successfully assigned chp11-set1113/quote-003 to worker1
46s         Normal    Scheduled               pod/quote-canary                  Successfully assigned chp11-set1113/quote-canary to worker1
44s         Normal    Pulling                 pod/quote-001                     Pulling image "busybox"
43s         Normal    Pulling                 pod/quote-002                     Pulling image "busybox"
43s         Normal    Pulling                 pod/quote-003                     Pulling image "busybox"
43s         Normal    Pulling                 pod/quote-canary                  Pulling image "busybox"
42s         Normal    Pulled                  pod/quote-001                     Successfully pulled image "busybox" in 1.941116668s
41s         Normal    Created                 pod/quote-001                     Created container index-creator
41s         Normal    Started                 pod/quote-001                     Started container index-creator
40s         Normal    Pulling                 pod/quote-001                     Pulling image "luksa/quote-writer:0.1"
40s         Normal    Pulled                  pod/quote-002                     Successfully pulled image "busybox" in 3.256341214s
40s         Normal    Created                 pod/quote-002                     Created container index-creator
39s         Normal    Started                 pod/quote-002                     Started container index-creator
38s         Normal    Pulling                 pod/quote-002                     Pulling image "luksa/quote-writer:0.1"
38s         Normal    Pulled                  pod/quote-003                     Successfully pulled image "busybox" in 4.766586024s
38s         Normal    Created                 pod/quote-003                     Created container index-creator
37s         Normal    Started                 pod/quote-003                     Started container index-creator
37s         Normal    Pulling                 pod/quote-003                     Pulling image "luksa/quote-writer:0.1"
37s         Normal    ExternalProvisioning    persistentvolumeclaim/quiz-data   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
36s         Normal    Pulled                  pod/quote-canary                  Successfully pulled image "busybox" in 6.5255059s
36s         Normal    Created                 pod/quote-canary                  Created container index-creator
36s         Normal    Started                 pod/quote-canary                  Started container index-creator
35s         Normal    Pulling                 pod/quote-canary                  Pulling image "luksa/quote-writer:0.1"
34s         Normal    Pulled                  pod/quote-001                     Successfully pulled image "luksa/quote-writer:0.1" in 6.037024634s
34s         Normal    Created                 pod/quote-001                     Created container quote-writer
34s         Normal    Started                 pod/quote-001                     Started container quote-writer
33s         Normal    ProvisioningSucceeded   persistentvolumeclaim/quiz-data   Successfully provisioned volume pvc-6d13c238-3911-4191-a871-4b99b97d7448
32s         Normal    Pulled                  pod/quote-002                     Successfully pulled image "luksa/quote-writer:0.1" in 5.812218928s
32s         Normal    Created                 pod/quote-002                     Created container quote-writer
32s         Normal    Scheduled               pod/quiz                          Successfully assigned chp11-set1113/quiz to main
32s         Normal    Started                 pod/quote-002                     Started container quote-writer
32s         Normal    Pulled                  pod/quote-002                     Container image "nginx:alpine" already present on machine
31s         Normal    Created                 pod/quote-002                     Created container nginx
31s         Normal    Started                 pod/quote-002                     Started container nginx
30s         Normal    Pulled                  pod/quote-003                     Successfully pulled image "luksa/quote-writer:0.1" in 6.763272764s
30s         Normal    Created                 pod/quote-003                     Created container quote-writer
30s         Normal    Started                 pod/quote-003                     Started container quote-writer
30s         Normal    Pulled                  pod/quote-003                     Container image "nginx:alpine" already present on machine
30s         Normal    Created                 pod/quote-003                     Created container nginx
30s         Normal    Started                 pod/quote-003                     Started container nginx
28s         Normal    Pulled                  pod/quote-canary                  Successfully pulled image "luksa/quote-writer:0.1" in 6.768601415s
28s         Normal    Created                 pod/quote-canary                  Created container quote-writer
28s         Normal    Started                 pod/quote-canary                  Started container quote-writer
28s         Normal    Pulled                  pod/quote-canary                  Container image "nginx:alpine" already present on machine
27s         Normal    Created                 pod/quote-canary                  Created container nginx
27s         Normal    Started                 pod/quote-canary                  Started container nginx
27s         Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-initdb-script-installer:0.1"
21s         Normal    Pulled                  pod/quiz                          Successfully pulled image "luksa/quiz-initdb-script-installer:0.1" in 6.006887762s
21s         Normal    Created                 pod/quiz                          Created container installer
20s         Normal    Started                 pod/quiz                          Started container installer
19s         Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-api:0.1"
12s         Normal    Pulled                  pod/quiz                          Successfully pulled image "luksa/quiz-api:0.1" in 7.129855228s
12s         Normal    Created                 pod/quiz                          Created container quiz-api
12s         Normal    Started                 pod/quiz                          Started container quiz-api
12s         Normal    Pulled                  pod/quiz                          Container image "mongo:5" already present on machine
12s         Normal    Created                 pod/quiz                          Created container mongo
11s         Normal    Started                 pod/quiz                          Started container mongo
3s          Normal    Pulled                  pod/quote-001                     Container image "nginx:alpine" already present on machine
3s          Normal    Created                 pod/quote-001                     Created container nginx
2s          Normal    Started                 pod/quote-001                     Started container nginx
```
