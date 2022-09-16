# 10.3.2b Filtering objects with field selectors

### Objective

1. Explore how to filter objects by non-label properties
2. This technique is very useful.


### Notes

1. We do this via `field selectors`
2. The set of fields we can use in a field selector depends on the object type.
3. The `metadata.name` and `metadata.namespace` fields are always supported. 
4. Field selectors support the equal (= or ==) and not equal (!=) operator.
5. We can combine mutual field selectors by separating them with a comma.

### Misc

This is a better way to wait for a namespace (or any object) to be instantiated, where we use the jsonpath:

```
kubectl wait --for=jsonpath=.status.phase=Active ns/chp10-set1032b
```

This references this post:

> Conditions are generally better than phase. Phases were a mistake in our original pod implementation because they implied a single unified state machine, but we found that instead we had multiple orthogonal states that are better represented as separate conditions. You could try `kubectl wait --for=jsonpath=.status.phase=wish-i-was-a-condition`

https://github.com/kubernetes/kubernetes/issues/83094#issuecomment-542721478

### Events

```
kubectl get events -n=chp10-set1032b
LAST SEEN   TYPE      REASON                 OBJECT                            MESSAGE
20s         Normal    Scheduled              pod/kiada-001                     Successfully assigned chp10-set1032b/kiada-001 to main
20s         Normal    Scheduled              pod/kiada-002                     Successfully assigned chp10-set1032b/kiada-002 to worker1
20s         Normal    Scheduled              pod/kiada-003                     Successfully assigned chp10-set1032b/kiada-003 to worker1
20s         Warning   FailedMount            pod/kiada-001                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
20s         Warning   FailedMount            pod/kiada-002                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
20s         Normal    Scheduled              pod/kiada-canary                  Successfully assigned chp10-set1032b/kiada-canary to worker1
20s         Warning   FailedMount            pod/kiada-003                     MountVolume.SetUp failed for volume "etc-envoy" : secret "kiada-tls" not found
18s         Warning   FailedScheduling       pod/quiz                          0/2 nodes are available: 2 persistentvolumeclaim "quiz-data" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
18s         Normal    WaitForPodScheduled    persistentvolumeclaim/quiz-data   waiting for pod quiz to be scheduled
17s         Normal    Pulled                 pod/kiada-canary                  Container image "luksa/kiada:0.4" already present on machine
17s         Normal    Created                pod/kiada-canary                  Created container kiada
16s         Normal    Pulled                 pod/kiada-001                     Container image "luksa/kiada:0.4" already present on machine
16s         Normal    Started                pod/kiada-canary                  Started container kiada
16s         Normal    Created                pod/kiada-001                     Created container kiada
16s         Normal    Pulled                 pod/kiada-canary                  Container image "envoyproxy/envoy:v1.14.1" already present on machine
15s         Normal    Provisioning           persistentvolumeclaim/quiz-data   External provisioner is provisioning volume for claim "chp10-set1032b/quiz-data"
16s         Normal    Started                pod/kiada-001                     Started container kiada
16s         Normal    Created                pod/kiada-canary                  Created container envoy
14s         Normal    Scheduled              pod/quote-001                     Successfully assigned chp10-set1032b/quote-001 to worker1
16s         Normal    Pulled                 pod/kiada-001                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
15s         Normal    Started                pod/kiada-canary                  Started container envoy
14s         Normal    Scheduled              pod/quote-002                     Successfully assigned chp10-set1032b/quote-002 to worker1
15s         Normal    Created                pod/kiada-001                     Created container envoy
15s         Normal    Pulled                 pod/kiada-003                     Container image "luksa/kiada:0.4" already present on machine
15s         Normal    Started                pod/kiada-001                     Started container envoy
15s         Normal    Created                pod/kiada-003                     Created container kiada
14s         Normal    Scheduled              pod/quote-003                     Successfully assigned chp10-set1032b/quote-003 to worker1
13s         Normal    Scheduled              pod/quote-canary                  Successfully assigned chp10-set1032b/quote-canary to worker1
15s         Normal    Started                pod/kiada-003                     Started container kiada
15s         Normal    Pulled                 pod/kiada-003                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
14s         Normal    Created                pod/kiada-003                     Created container envoy
13s         Normal    Started                pod/kiada-003                     Started container envoy
13s         Normal    Pulled                 pod/kiada-002                     Container image "luksa/kiada:0.4" already present on machine
12s         Normal    Created                pod/kiada-002                     Created container kiada
12s         Normal    ExternalProvisioning   persistentvolumeclaim/quiz-data   waiting for a volume to be created, either by external provisioner "microk8s.io/hostpath" or manually created by system administrator
11s         Normal    Started                pod/kiada-002                     Started container kiada
11s         Normal    Pulled                 pod/kiada-002                     Container image "envoyproxy/envoy:v1.14.1" already present on machine
10s         Normal    Created                pod/kiada-002                     Created container envoy
8s          Normal    Started                pod/kiada-002                     Started container envoy
7s          Normal    Pulling                pod/quote-001                     Pulling image "luksa/quote-writer:0.1"
7s          Normal    Pulling                pod/quote-002                     Pulling image "luksa/quote-writer:0.1"
6s          Normal    Pulling                pod/quote-003                     Pulling image "luksa/quote-writer:0.1"
6s          Normal    Pulling                pod/quote-canary                  Pulling image "luksa/quote-writer:0.1"
4s          Normal    Pulled                 pod/quote-001                     Successfully pulled image "luksa/quote-writer:0.1" in 2.738337801s
4s          Normal    Created                pod/quote-001                     Created container quote-writer
4s          Normal    Started                pod/quote-001                     Started container quote-writer
4s          Normal    Pulled                 pod/quote-001                     Container image "nginx:alpine" already present on machine
3s          Normal    Created                pod/quote-001                     Created container nginx
3s          Normal    Started                pod/quote-001                     Started container nginx
2s          Normal    Pulled                 pod/quote-002                     Successfully pulled image "luksa/quote-writer:0.1" in 4.453820347s
2s          Normal    Created                pod/quote-002                     Created container quote-writer
2s          Normal    Started                pod/quote-002                     Started container quote-writer
2s          Normal    Pulled                 pod/quote-002                     Container image "nginx:alpine" already present on machine
1s          Normal    Created                pod/quote-002                     Created container nginx
0s          Normal    Started                pod/quote-002                     Started container nginx
```