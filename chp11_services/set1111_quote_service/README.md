# 11.1.1 Introducing services


### Objective

1. Explore how to implement services for pods

### Events

```
kubectl get events -n=chp11-set1111
LAST SEEN   TYPE      REASON                  OBJECT                            MESSAGE
25s         Warning   FailedScheduling        pod/quiz                          0/2 nodes are available: 2 persistentvolumeclaim "quiz-data" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
25s         Normal    WaitForPodScheduled     persistentvolumeclaim/quiz-data   waiting for pod quiz to be scheduled
24s         Normal    Scheduled               pod/quote-001                     Successfully assigned chp11-set1111/quote-001 to main
24s         Normal    Scheduled               pod/quote-002                     Successfully assigned chp11-set1111/quote-002 to worker1
24s         Normal    Scheduled               pod/quote-003                     Successfully assigned chp11-set1111/quote-003 to worker1
23s         Normal    Scheduled               pod/quote-canary                  Successfully assigned chp11-set1111/quote-canary to worker1
23s         Normal    Provisioning            persistentvolumeclaim/quiz-data   External provisioner is provisioning volume for claim "chp11-set1111/quiz-data"
22s         Normal    Pulling                 pod/quote-001                     Pulling image "busybox"
21s         Normal    Pulling                 pod/quote-002                     Pulling image "busybox"
20s         Normal    Pulling                 pod/quote-003                     Pulling image "busybox"
20s         Normal    Pulling                 pod/quote-canary                  Pulling image "busybox"
20s         Normal    Pulled                  pod/quote-001                     Successfully pulled image "busybox" in 1.886266776s
20s         Normal    Created                 pod/quote-001                     Created container index-creator
20s         Normal    Started                 pod/quote-001                     Started container index-creator
19s         Normal    Pulled                  pod/quote-002                     Successfully pulled image "busybox" in 1.992957314s
19s         Normal    Created                 pod/quote-002                     Created container index-creator
19s         Normal    Pulling                 pod/quote-001                     Pulling image "luksa/quote-writer:0.1"
19s         Normal    Started                 pod/quote-002                     Started container index-creator
18s         Normal    Pulling                 pod/quote-002                     Pulling image "luksa/quote-writer:0.1"
17s         Normal    Pulled                  pod/quote-003                     Successfully pulled image "busybox" in 3.079783938s
17s         Normal    Created                 pod/quote-003                     Created container index-creator
17s         Normal    Started                 pod/quote-003                     Started container index-creator
17s         Normal    Pulling                 pod/quote-003                     Pulling image "luksa/quote-writer:0.1"
16s         Normal    ExternalProvisioning    persistentvolumeclaim/quiz-data   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
15s         Normal    Pulled                  pod/quote-canary                  Successfully pulled image "busybox" in 5.036769473s
15s         Normal    Created                 pod/quote-canary                  Created container index-creator
15s         Normal    Started                 pod/quote-canary                  Started container index-creator
14s         Normal    Pulling                 pod/quote-canary                  Pulling image "luksa/quote-writer:0.1"
13s         Normal    Pulled                  pod/quote-002                     Successfully pulled image "luksa/quote-writer:0.1" in 4.311979188s
13s         Normal    Created                 pod/quote-002                     Created container quote-writer
13s         Normal    Started                 pod/quote-002                     Started container quote-writer
13s         Normal    Pulled                  pod/quote-002                     Container image "nginx:alpine" already present on machine
12s         Normal    Created                 pod/quote-002                     Created container nginx
12s         Normal    ProvisioningSucceeded   persistentvolumeclaim/quiz-data   Successfully provisioned volume pvc-df8d4646-f23c-4383-a342-51c09ae99118
12s         Normal    Started                 pod/quote-002                     Started container nginx
12s         Normal    Pulled                  pod/quote-001                     Successfully pulled image "luksa/quote-writer:0.1" in 6.95603795s
12s         Normal    Created                 pod/quote-001                     Created container quote-writer
12s         Normal    Started                 pod/quote-001                     Started container quote-writer
12s         Normal    Pulling                 pod/quote-001                     Pulling image "nginx:alpine"
11s         Normal    Pulled                  pod/quote-003                     Successfully pulled image "luksa/quote-writer:0.1" in 5.197405415s
11s         Normal    Created                 pod/quote-003                     Created container quote-writer
11s         Normal    Started                 pod/quote-003                     Started container quote-writer
11s         Normal    Pulled                  pod/quote-003                     Container image "nginx:alpine" already present on machine
11s         Normal    Created                 pod/quote-003                     Created container nginx
10s         Normal    Scheduled               pod/quiz                          Successfully assigned chp11-set1111/quiz to worker1
10s         Normal    Started                 pod/quote-003                     Started container nginx
9s          Normal    Pulled                  pod/quote-canary                  Successfully pulled image "luksa/quote-writer:0.1" in 5.124152005s
9s          Normal    Created                 pod/quote-canary                  Created container quote-writer
9s          Normal    Started                 pod/quote-canary                  Started container quote-writer
9s          Normal    Pulled                  pod/quote-canary                  Container image "nginx:alpine" already present on machine
9s          Normal    Created                 pod/quote-canary                  Created container nginx
8s          Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-initdb-script-installer:0.1"
8s          Normal    Started                 pod/quote-canary                  Started container nginx
6s          Normal    Pulled                  pod/quiz                          Successfully pulled image "luksa/quiz-initdb-script-installer:0.1" in 2.187037903s
5s          Normal    Created                 pod/quiz                          Created container installer
5s          Normal    Started                 pod/quiz                          Started container installer
4s          Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-api:0.1"
4s          Normal    Pulled                  pod/quote-001                     Successfully pulled image "nginx:alpine" in 7.895211916s
4s          Normal    Created                 pod/quote-001                     Created container nginx
3s          Normal    Started                 pod/quote-001                     Started container nginx
2s          Normal    Pulled                  pod/quiz                          Successfully pulled image "luksa/quiz-api:0.1" in 1.860659067s
2s          Normal    Created                 pod/quiz                          Created container quiz-api
1s          Normal    Started                 pod/quiz                          Started container quiz-api
1s          Normal    Pulled                  pod/quiz                          Container image "mongo:5" already present on machine
1s          Normal    Created                 pod/quiz                          Created container mongo
1s          Normal    Started                 pod/quiz                          Started container mongo
```
