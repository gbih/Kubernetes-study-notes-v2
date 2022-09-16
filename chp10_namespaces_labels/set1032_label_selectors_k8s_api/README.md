# 10.3.2 Utilizing label selectors within Kubernetes API objects

### Objective

1. Understand how to use selectors within Kubernetes API objects.

### Events

```
kubectl get events -n=chp10-set1032
LAST SEEN   TYPE      REASON                  OBJECT                            MESSAGE
2m13s       Normal    Scheduled               pod/kiada-001                     Successfully assigned chp10-set1032/kiada-001 to main
2m13s       Normal    Scheduled               pod/kiada-002                     Successfully assigned chp10-set1032/kiada-002 to worker1
2m14s       Warning   FailedMount             pod/kiada-001                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
2m14s       Warning   FailedMount             pod/kiada-002                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
2m13s       Normal    Scheduled               pod/kiada-003                     Successfully assigned chp10-set1032/kiada-003 to worker1
2m13s       Normal    Scheduled               pod/kiada-canary                  Successfully assigned chp10-set1032/kiada-canary to worker1
2m11s       Warning   FailedScheduling        pod/quiz                          0/2 nodes are available: 2 persistentvolumeclaim "quiz-data" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
2m11s       Normal    WaitForPodScheduled     persistentvolumeclaim/quiz-data   waiting for pod quiz to be scheduled
2m10s       Normal    Pulled                  pod/kiada-003                     Container image "luksa/kiada:0.4" already present on machine
2m10s       Normal    Created                 pod/kiada-003                     Created container kiada
2m10s       Normal    Pulled                  pod/kiada-001                     Container image "luksa/kiada:0.4" already present on machine
2m10s       Normal    Started                 pod/kiada-003                     Started container kiada
2m8s        Normal    Scheduled               pod/quote-001                     Successfully assigned chp10-set1032/quote-001 to worker1
2m10s       Normal    Created                 pod/kiada-001                     Created container kiada
2m10s       Normal    Pulled                  pod/kiada-003                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
2m9s        Normal    Started                 pod/kiada-001                     Started container kiada
2m8s        Normal    Provisioning            persistentvolumeclaim/quiz-data   External provisioner is provisioning volume for claim "chp10-set1032/quiz-data"
2m7s        Normal    Scheduled               pod/quote-002                     Successfully assigned chp10-set1032/quote-002 to worker1
2m9s        Normal    Created                 pod/kiada-003                     Created container envoy
2m9s        Normal    Pulled                  pod/kiada-001                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
2m8s        Normal    Started                 pod/kiada-003                     Started container envoy
2m8s        Normal    Created                 pod/kiada-001                     Created container envoy
2m8s        Normal    Pulled                  pod/kiada-canary                  Container image "luksa/kiada:0.4" already present on machine
2m6s        Normal    Scheduled               pod/quote-003                     Successfully assigned chp10-set1032/quote-003 to worker1
2m7s        Normal    Started                 pod/kiada-001                     Started container envoy
2m7s        Normal    Created                 pod/kiada-canary                  Created container kiada
2m7s        Normal    Started                 pod/kiada-canary                  Started container kiada
2m5s        Normal    Scheduled               pod/quote-canary                  Successfully assigned chp10-set1032/quote-canary to worker1
2m7s        Normal    Pulled                  pod/kiada-canary                  Container image "envoyproxy/envoy:v1.14.1" already present on machine
2m7s        Normal    Created                 pod/kiada-canary                  Created container envoy
2m6s        Normal    Started                 pod/kiada-canary                  Started container envoy
2m4s        Normal    Pulled                  pod/kiada-002                     Container image "luksa/kiada:0.4" already present on machine
2m4s        Normal    Created                 pod/kiada-002                     Created container kiada
2m2s        Normal    Started                 pod/kiada-002                     Started container kiada
2m2s        Normal    Pulled                  pod/kiada-002                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
2m2s        Normal    Pulling                 pod/quote-001                     Pulling image "luksa/quote-writer:0.1"
2m1s        Normal    Pulling                 pod/quote-002                     Pulling image "luksa/quote-writer:0.1"
2m1s        Normal    Created                 pod/kiada-002                     Created container envoy
2m          Normal    Pulling                 pod/quote-canary                  Pulling image "luksa/quote-writer:0.1"
2m          Normal    Started                 pod/kiada-002                     Started container envoy
2m          Normal    Pulling                 pod/quote-003                     Pulling image "luksa/quote-writer:0.1"
119s        Normal    Pulled                  pod/quote-001                     Successfully pulled image "luksa/quote-writer:0.1" in 2.724114581s
119s        Normal    Created                 pod/quote-001                     Created container quote-writer
118s        Normal    Started                 pod/quote-001                     Started container quote-writer
118s        Normal    Pulled                  pod/quote-001                     Container image "nginx:alpine" already present on machine
117s        Normal    Created                 pod/quote-001                     Created container nginx
117s        Normal    Started                 pod/quote-001                     Started container nginx
117s        Normal    Pulled                  pod/quote-002                     Successfully pulled image "luksa/quote-writer:0.1" in 4.565304577s
117s        Normal    Created                 pod/quote-002                     Created container quote-writer
115s        Normal    Scheduled               pod/kiada-front-end               Successfully assigned chp10-set1032/kiada-front-end to worker1
116s        Normal    Started                 pod/quote-002                     Started container quote-writer
116s        Normal    Pulled                  pod/quote-002                     Container image "nginx:alpine" already present on machine
116s        Normal    Created                 pod/quote-002                     Created container nginx
114s        Normal    Started                 pod/quote-002                     Started container nginx
114s        Normal    Pulled                  pod/quote-canary                  Successfully pulled image "luksa/quote-writer:0.1" in 5.590882051s
114s        Normal    Created                 pod/quote-canary                  Created container quote-writer
113s        Normal    Started                 pod/quote-canary                  Started container quote-writer
113s        Normal    Pulled                  pod/quote-canary                  Container image "nginx:alpine" already present on machine
113s        Normal    Created                 pod/quote-canary                  Created container nginx
112s        Normal    Pulling                 pod/kiada-front-end               Pulling image "georgebaptista/kiada:0.4"
112s        Normal    Pulled                  pod/quote-003                     Successfully pulled image "luksa/quote-writer:0.1" in 7.886895623s
112s        Normal    Started                 pod/quote-canary                  Started container nginx
112s        Normal    Created                 pod/quote-003                     Created container quote-writer
111s        Normal    Started                 pod/quote-003                     Started container quote-writer
111s        Normal    Pulled                  pod/quote-003                     Container image "nginx:alpine" already present on machine
111s        Normal    Created                 pod/quote-003                     Created container nginx
110s        Normal    Started                 pod/quote-003                     Started container nginx
110s        Normal    ExternalProvisioning    persistentvolumeclaim/quiz-data   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
107s        Normal    ProvisioningSucceeded   persistentvolumeclaim/quiz-data   Successfully provisioned volume pvc-cf3122e5-293e-47b8-b7e5-62930511af50
105s        Normal    Scheduled               pod/quiz                          Successfully assigned chp10-set1032/quiz to worker1
103s        Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-initdb-script-installer:0.1"
25s         Normal    Pulled                  pod/kiada-front-end               Successfully pulled image "georgebaptista/kiada:0.4" in 1m26.563545305s
25s         Normal    Created                 pod/kiada-front-end               Created container kiada
25s         Normal    Started                 pod/kiada-front-end               Started container kiada
25s         Normal    Pulled                  pod/kiada-front-end               Container image "envoyproxy/envoy:v1.14.1" already present on machine
25s         Normal    Created                 pod/kiada-front-end               Created container envoy
24s         Normal    Started                 pod/kiada-front-end               Started container envoy
23s         Normal    Killing                 pod/kiada-front-end               Stopping container kiada
23s         Normal    Killing                 pod/kiada-front-end               Stopping container envoy
23s         Normal    Pulled                  pod/quiz                          Successfully pulled image "luksa/quiz-initdb-script-installer:0.1" in 1m20.653744599s
22s         Normal    Created                 pod/quiz                          Created container installer
21s         Normal    Started                 pod/quiz                          Started container installer
19s         Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-api:0.1"
17s         Normal    Pulled                  pod/quiz                          Successfully pulled image "luksa/quiz-api:0.1" in 2.347285079s
17s         Normal    Created                 pod/quiz                          Created container quiz-api
16s         Normal    Started                 pod/quiz                          Started container quiz-api
16s         Normal    Pulled                  pod/quiz                          Container image "mongo:5" already present on machine
16s         Normal    Created                 pod/quiz                          Created container mongo
16s         Normal    Started                 pod/quiz                          Started container mongo
11s         Normal    Scheduled               pod/kiada-front-end               Successfully assigned chp10-set1032/kiada-front-end to worker1
10s         Normal    Pulled                  pod/kiada-front-end               Container image "georgebaptista/kiada:0.4" already present on machine
10s         Normal    Created                 pod/kiada-front-end               Created container kiada
9s          Normal    Started                 pod/kiada-front-end               Started container kiada
9s          Normal    Pulled                  pod/kiada-front-end               Container image "envoyproxy/envoy:v1.14.1" already present on machine
8s          Normal    Created                 pod/kiada-front-end               Created container envoy
8s          Normal    Started                 pod/kiada-front-end               Started container envoy
```