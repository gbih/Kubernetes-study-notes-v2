# 10.4.2 Adding annotations to objects

### Objective

1. Explore how to add annotations to objects, both imperatively and declaratively

### Notes

* A good use of annotations is to add a description to each pod or other object so that other users can quickly see information about an object without having to look it up elsewhere.

* An annotation value can contain any character and can be up to 256 KB long.

* An annotation value must be a string, but contain plain text, YAML, JSON, or even Base64-Encoded value.

### Events

```
kubectl get events -n=chp10-set1042
LAST SEEN   TYPE      REASON                  OBJECT                            MESSAGE
32s         Normal    Scheduled               pod/kiada-001                     Successfully assigned chp10-set1042/kiada-001 to main
31s         Normal    Scheduled               pod/kiada-002                     Successfully assigned chp10-set1042/kiada-002 to worker1
31s         Normal    Scheduled               pod/kiada-003                     Successfully assigned chp10-set1042/kiada-003 to worker1
31s         Warning   FailedMount             pod/kiada-002                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
31s         Warning   FailedMount             pod/kiada-003                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
31s         Normal    Scheduled               pod/kiada-canary                  Successfully assigned chp10-set1042/kiada-canary to worker1
31s         Warning   FailedMount             pod/kiada-001                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
29s         Warning   FailedScheduling        pod/quiz                          0/2 nodes are available: 2 persistentvolumeclaim "quiz-data" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
29s         Normal    WaitForPodScheduled     persistentvolumeclaim/quiz-data   waiting for pod quiz to be scheduled
28s         Normal    Pulled                  pod/kiada-002                     Container image "luksa/kiada:0.4" already present on machine
28s         Normal    Created                 pod/kiada-002                     Created container kiada
27s         Normal    Started                 pod/kiada-002                     Started container kiada
27s         Normal    Pulled                  pod/kiada-002                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
27s         Normal    Created                 pod/kiada-002                     Created container envoy
26s         Normal    Pulled                  pod/kiada-001                     Container image "luksa/kiada:0.4" already present on machine
26s         Normal    Provisioning            persistentvolumeclaim/quiz-data   External provisioner is provisioning volume for claim "chp10-set1042/quiz-data"
26s         Normal    Scheduled               pod/quote-001                     Successfully assigned chp10-set1042/quote-001 to worker1
26s         Normal    Created                 pod/kiada-001                     Created container kiada
26s         Normal    Pulled                  pod/kiada-canary                  Container image "luksa/kiada:0.4" already present on machine
26s         Normal    Started                 pod/kiada-002                     Started container envoy
25s         Normal    Started                 pod/kiada-001                     Started container kiada
25s         Normal    Scheduled               pod/quote-002                     Successfully assigned chp10-set1042/quote-002 to worker1
26s         Normal    Created                 pod/kiada-canary                  Created container kiada
25s         Normal    Pulled                  pod/kiada-001                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
25s         Normal    Pulled                  pod/kiada-003                     Container image "luksa/kiada:0.4" already present on machine
25s         Normal    Scheduled               pod/quote-003                     Successfully assigned chp10-set1042/quote-003 to worker1
25s         Normal    Created                 pod/kiada-001                     Created container envoy
25s         Normal    Started                 pod/kiada-canary                  Started container kiada
25s         Normal    Pulled                  pod/kiada-canary                  Container image "envoyproxy/envoy:v1.14.1" already present on machine
24s         Normal    Started                 pod/kiada-001                     Started container envoy
24s         Normal    Created                 pod/kiada-003                     Created container kiada
23s         Normal    Scheduled               pod/quote-canary                  Successfully assigned chp10-set1042/quote-canary to worker1
24s         Normal    Created                 pod/kiada-canary                  Created container envoy
23s         Normal    Started                 pod/kiada-canary                  Started container envoy
22s         Normal    Started                 pod/kiada-003                     Started container kiada
22s         Normal    Pulled                  pod/kiada-003                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
21s         Normal    Created                 pod/kiada-003                     Created container envoy
20s         Normal    Started                 pod/kiada-003                     Started container envoy
19s         Normal    Pulling                 pod/quote-001                     Pulling image "luksa/quote-writer:0.1"
18s         Normal    Pulling                 pod/quote-002                     Pulling image "luksa/quote-writer:0.1"
18s         Normal    ExternalProvisioning    persistentvolumeclaim/quiz-data   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
18s         Normal    Pulling                 pod/quote-003                     Pulling image "luksa/quote-writer:0.1"
17s         Normal    Pulled                  pod/quote-001                     Successfully pulled image "luksa/quote-writer:0.1" in 2.523779566s
17s         Normal    Created                 pod/quote-001                     Created container quote-writer
16s         Normal    Pulling                 pod/quote-canary                  Pulling image "luksa/quote-writer:0.1"
16s         Normal    Started                 pod/quote-001                     Started container quote-writer
16s         Normal    Pulled                  pod/quote-001                     Container image "nginx:alpine" already present on machine
15s         Normal    Created                 pod/quote-001                     Created container nginx
15s         Normal    Started                 pod/quote-001                     Started container nginx
15s         Normal    Pulled                  pod/quote-002                     Successfully pulled image "luksa/quote-writer:0.1" in 3.557147825s
14s         Normal    Created                 pod/quote-002                     Created container quote-writer
14s         Normal    Started                 pod/quote-002                     Started container quote-writer
14s         Normal    Pulled                  pod/quote-002                     Container image "nginx:alpine" already present on machine
14s         Normal    Created                 pod/quote-002                     Created container nginx
13s         Normal    Started                 pod/quote-002                     Started container nginx
13s         Normal    Pulled                  pod/quote-003                     Successfully pulled image "luksa/quote-writer:0.1" in 5.345213068s
12s         Normal    Scheduled               pod/kiada-front-end               Successfully assigned chp10-set1042/kiada-front-end to worker1
12s         Normal    Created                 pod/quote-003                     Created container quote-writer
11s         Normal    Started                 pod/quote-003                     Started container quote-writer
11s         Normal    Pulled                  pod/quote-003                     Container image "nginx:alpine" already present on machine
11s         Normal    Created                 pod/quote-003                     Created container nginx
10s         Normal    Started                 pod/quote-003                     Started container nginx
10s         Normal    Pulled                  pod/quote-canary                  Successfully pulled image "luksa/quote-writer:0.1" in 6.011846614s
10s         Normal    Created                 pod/quote-canary                  Created container quote-writer
9s          Normal    Started                 pod/quote-canary                  Started container quote-writer
9s          Normal    Pulled                  pod/quote-canary                  Container image "nginx:alpine" already present on machine
9s          Normal    Created                 pod/quote-canary                  Created container nginx
8s          Normal    Started                 pod/quote-canary                  Started container nginx
8s          Normal    Pulled                  pod/kiada-front-end               Container image "georgebaptista/kiada:0.4" already present on machine
8s          Normal    Created                 pod/kiada-front-end               Created container kiada
7s          Normal    Started                 pod/kiada-front-end               Started container kiada
7s          Normal    Pulled                  pod/kiada-front-end               Container image "envoyproxy/envoy:v1.14.1" already present on machine
6s          Normal    Created                 pod/kiada-front-end               Created container envoy
6s          Normal    ProvisioningSucceeded   persistentvolumeclaim/quiz-data   Successfully provisioned volume pvc-52aa4b82-960a-485a-acb1-7691cf841c7f
6s          Normal    Started                 pod/kiada-front-end               Started container envoy
5s          Normal    Scheduled               pod/quiz                          Successfully assigned chp10-set1042/quiz to worker1
3s          Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-initdb-script-installer:0.1"
1s          Normal    Pulled                  pod/quiz                          Successfully pulled image "luksa/quiz-initdb-script-installer:0.1" in 1.866971567s
1s          Normal    Created                 pod/quiz                          Created container installer
1s          Normal    Started                 pod/quiz                          Started container installer
0s          Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-api:0.1"
```