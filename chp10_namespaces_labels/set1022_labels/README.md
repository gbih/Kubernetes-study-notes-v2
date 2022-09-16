# 10.2.2 Attaching pods to labels

### Objective

1. Understand how to use labels with pods

### Events

```
kubectl get events -n=chp10-set1022
LAST SEEN   TYPE      REASON                  OBJECT                            MESSAGE
65s         Normal    Scheduled               pod/kiada-001                     Successfully assigned chp10-set1022/kiada-001 to main
65s         Normal    Scheduled               pod/kiada-002                     Successfully assigned chp10-set1022/kiada-002 to worker1
65s         Normal    Scheduled               pod/kiada-003                     Successfully assigned chp10-set1022/kiada-003 to worker1
65s         Warning   FailedMount             pod/kiada-001                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
65s         Warning   FailedMount             pod/kiada-002                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
65s         Normal    Scheduled               pod/kiada-canary                  Successfully assigned chp10-set1022/kiada-canary to worker1
65s         Warning   FailedMount             pod/kiada-003                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
64s         Warning   FailedScheduling        pod/quiz                          0/2 nodes are available: 2 persistentvolumeclaim "quiz-data" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
64s         Normal    WaitForPodScheduled     persistentvolumeclaim/quiz-data   waiting for pod quiz to be scheduled
63s         Normal    Pulled                  pod/kiada-001                     Container image "luksa/kiada:0.4" already present on machine
63s         Normal    Provisioning            persistentvolumeclaim/quiz-data   External provisioner is provisioning volume for claim "chp10-set1022/quiz-data"
62s         Normal    Created                 pod/kiada-001                     Created container kiada
62s         Normal    Scheduled               pod/quote-001                     Successfully assigned chp10-set1022/quote-001 to worker1
62s         Normal    Started                 pod/kiada-001                     Started container kiada
61s         Normal    Scheduled               pod/quote-002                     Successfully assigned chp10-set1022/quote-002 to worker1
62s         Normal    Pulled                  pod/kiada-001                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
61s         Normal    Created                 pod/kiada-001                     Created container envoy
60s         Normal    Scheduled               pod/quote-003                     Successfully assigned chp10-set1022/quote-003 to worker1
61s         Normal    Started                 pod/kiada-001                     Started container envoy
60s         Normal    Pulling                 pod/kiada-canary                  Pulling image "luksa/kiada:0.4"
60s         Normal    Scheduled               pod/quote-canary                  Successfully assigned chp10-set1022/quote-canary to worker1
57s         Normal    Pulling                 pod/kiada-002                     Pulling image "luksa/kiada:0.4"
57s         Normal    Pulling                 pod/quote-001                     Pulling image "luksa/quote-writer:0.1"
57s         Normal    Pulling                 pod/kiada-003                     Pulling image "luksa/kiada:0.4"
56s         Normal    Pulling                 pod/quote-002                     Pulling image "luksa/quote-writer:0.1"
56s         Normal    Pulling                 pod/quote-003                     Pulling image "luksa/quote-writer:0.1"
55s         Normal    ExternalProvisioning    persistentvolumeclaim/quiz-data   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
55s         Normal    Pulling                 pod/quote-canary                  Pulling image "luksa/quote-writer:0.1"
47s         Normal    ProvisioningSucceeded   persistentvolumeclaim/quiz-data   Successfully provisioned volume pvc-a9026c3e-aedf-4622-ba30-d7f1ef0a9480
45s         Normal    Scheduled               pod/quiz                          Successfully assigned chp10-set1022/quiz to worker1
36s         Normal    Pulling                 pod/quiz                          Pulling image "luksa/quiz-initdb-script-installer:0.1"
```
