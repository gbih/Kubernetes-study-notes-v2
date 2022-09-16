# 10.2.2 Attaching pods to labels

### Objective

1. Understand how to use labels with pods


### Events

```
kubectl get events -n=chp10-set1031
LAST SEEN   TYPE      REASON                  OBJECT                            MESSAGE
56s         Normal    Scheduled               pod/kiada-001                     Successfully assigned chp10-set1031/kiada-001 to main
56s         Normal    Scheduled               pod/kiada-002                     Successfully assigned chp10-set1031/kiada-002 to worker1
56s         Warning   FailedMount             pod/kiada-002                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
56s         Normal    Scheduled               pod/kiada-003                     Successfully assigned chp10-set1031/kiada-003 to worker1
56s         Warning   FailedMount             pod/kiada-001                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
55s         Normal    Scheduled               pod/kiada-canary                  Successfully assigned chp10-set1031/kiada-canary to worker1
55s         Warning   FailedScheduling        pod/quiz                          0/2 nodes are available: 2 persistentvolumeclaim "quiz-data" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
55s         Normal    WaitForPodScheduled     persistentvolumeclaim/quiz-data   waiting for pod quiz to be scheduled
54s         Normal    Pulled                  pod/kiada-canary                  Container image "luksa/kiada:0.4" already present on machine
54s         Normal    Created                 pod/kiada-canary                  Created container kiada
53s         Normal    Provisioning            persistentvolumeclaim/quiz-data   External provisioner is provisioning volume for claim "chp10-set1031/quiz-data"
52s         Normal    Scheduled               pod/quote-001                     Successfully assigned chp10-set1031/quote-001 to worker1
53s         Normal    Started                 pod/kiada-canary                  Started container kiada
53s         Normal    Pulled                  pod/kiada-canary                  Container image "envoyproxy/envoy:v1.14.1" already present on machine
51s         Normal    Scheduled               pod/quote-002                     Successfully assigned chp10-set1031/quote-002 to worker1
52s         Normal    Pulled                  pod/kiada-001                     Container image "luksa/kiada:0.4" already present on machine
53s         Normal    Pulled                  pod/kiada-003                     Container image "luksa/kiada:0.4" already present on machine
52s         Normal    Created                 pod/kiada-001                     Created container kiada
52s         Normal    Created                 pod/kiada-003                     Created container kiada
51s         Normal    Scheduled               pod/quote-003                     Successfully assigned chp10-set1031/quote-003 to worker1
52s         Normal    Created                 pod/kiada-canary                  Created container envoy
51s         Normal    Started                 pod/kiada-001                     Started container kiada
51s         Normal    Pulled                  pod/kiada-001                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
51s         Normal    Created                 pod/kiada-001                     Created container envoy
50s         Normal    Scheduled               pod/quote-canary                  Successfully assigned chp10-set1031/quote-canary to worker1
51s         Normal    Started                 pod/kiada-003                     Started container kiada
51s         Normal    Pulled                  pod/kiada-003                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
50s         Normal    Started                 pod/kiada-001                     Started container envoy
51s         Normal    Pulled                  pod/kiada-002                     Container image "luksa/kiada:0.4" already present on machine
50s         Normal    Started                 pod/kiada-canary                  Started container envoy
50s         Normal    Created                 pod/kiada-002                     Created container kiada
50s         Normal    Created                 pod/kiada-003                     Created container envoy
48s         Normal    Started                 pod/kiada-002                     Started container kiada
48s         Normal    Pulled                  pod/kiada-002                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
48s         Normal    Started                 pod/kiada-003                     Started container envoy
47s         Normal    Created                 pod/kiada-002                     Created container envoy
45s         Normal    Started                 pod/kiada-002                     Started container envoy
44s         Normal    Pulling                 pod/quote-001                     Pulling image "luksa/quote-writer:0.1"
43s         Normal    Pulling                 pod/quote-002                     Pulling image "luksa/quote-writer:0.1"
43s         Normal    Pulling                 pod/quote-003                     Pulling image "luksa/quote-writer:0.1"
43s         Normal    Pulling                 pod/quote-canary                  Pulling image "luksa/quote-writer:0.1"
41s         Normal    Pulled                  pod/quote-001                     Successfully pulled image "luksa/quote-writer:0.1" in 2.585304594s
41s         Normal    Created                 pod/quote-001                     Created container quote-writer
41s         Normal    Started                 pod/quote-001                     Started container quote-writer
41s         Normal    Pulled                  pod/quote-001                     Container image "nginx:alpine" already present on machine
40s         Normal    Created                 pod/quote-001                     Created container nginx
40s         Normal    Started                 pod/quote-001                     Started container nginx
39s         Normal    Pulled                  pod/quote-002                     Successfully pulled image "luksa/quote-writer:0.1" in 3.919266338s
39s         Normal    Created                 pod/quote-002                     Created container quote-writer
38s         Normal    Killing                 pod/kiada-canary                  Stopping container kiada
38s         Normal    Killing                 pod/kiada-canary                  Stopping container envoy
38s         Normal    Started                 pod/quote-002                     Started container quote-writer
38s         Normal    Pulled                  pod/quote-002                     Container image "nginx:alpine" already present on machine
38s         Normal    Created                 pod/quote-002                     Created container nginx
36s         Normal    Pulled                  pod/quote-003                     Successfully pulled image "luksa/quote-writer:0.1" in 6.898540066s
36s         Normal    Started                 pod/quote-002                     Started container nginx
36s         Normal    Created                 pod/quote-003                     Created container quote-writer
35s         Normal    Started                 pod/quote-003                     Started container quote-writer
35s         Normal    Pulled                  pod/quote-003                     Container image "nginx:alpine" already present on machine
35s         Normal    Created                 pod/quote-003                     Created container nginx
34s         Normal    Started                 pod/quote-003                     Started container nginx
34s         Normal    Pulled                  pod/quote-canary                  Successfully pulled image "luksa/quote-writer:0.1" in 8.591081217s
34s         Normal    Created                 pod/quote-canary                  Created container quote-writer
33s         Normal    Started                 pod/quote-canary                  Started container quote-writer
33s         Normal    Pulled                  pod/quote-canary                  Container image "nginx:alpine" already present on machine
33s         Normal    ExternalProvisioning    persistentvolumeclaim/quiz-data   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
33s         Normal    Created                 pod/quote-canary                  Created container nginx
33s         Normal    Started                 pod/quote-canary                  Started container nginx
32s         Normal    Killing                 pod/quote-canary                  Stopping container quote-writer
32s         Normal    Killing                 pod/quote-canary                  Stopping container nginx
32s         Normal    ProvisioningSucceeded   persistentvolumeclaim/quiz-data   Successfully provisioned volume pvc-93419477-f135-4e19-a0af-3c1e0e2c4cb8
30s         Normal    Scheduled               pod/quiz                          Successfully assigned chp10-set1031/quiz to worker1
29s         Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-initdb-script-installer:0.1"
27s         Normal    Pulled                  pod/quiz                          Successfully pulled image "luksa/quiz-initdb-script-installer:0.1" in 1.907720351s
27s         Normal    Created                 pod/quiz                          Created container installer
27s         Normal    Started                 pod/quiz                          Started container installer
26s         Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-api:0.1"
24s         Normal    Pulled                  pod/quiz                          Successfully pulled image "luksa/quiz-api:0.1" in 2.179722089s
24s         Normal    Created                 pod/quiz                          Created container quiz-api
24s         Normal    Started                 pod/quiz                          Started container quiz-api
24s         Normal    Pulled                  pod/quiz                          Container image "mongo:5" already present on machine
24s         Normal    Created                 pod/quiz                          Created container mongo
23s         Normal    Started                 pod/quiz                          Started container mongo
```