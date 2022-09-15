# 8.2.3 Using a claim and volume in a single pod

### Objective

1. Explore using a persistent volume in a single pod at a time.

### Notes

* To use a persistent volume in a pod, you define a volume within the pod in which you refer to the PersistentVolumeClaim object.

### Events

```
kubectl get event -n=chp08-set823
LAST SEEN   TYPE      REASON             OBJECT     MESSAGE
67s         Warning   FailedScheduling   pod/quiz   0/2 nodes are available: 2 persistentvolumeclaim "quiz-data" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
66s         Warning   FailedScheduling   pod/quiz   0/2 nodes are available: 2 persistentvolumeclaim "quiz-data" not found. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
64s         Normal    Scheduled          pod/quiz   Successfully assigned chp08-set823/quiz to worker1
62s         Normal    Pulled             pod/quiz   Container image "georgebaptista/quiz-api:0.1" already present on machine
62s         Normal    Created            pod/quiz   Created container quiz-api
62s         Normal    Started            pod/quiz   Started container quiz-api
62s         Normal    Pulled             pod/quiz   Container image "mongo:5" already present on machine
62s         Normal    Created            pod/quiz   Created container mongo
61s         Normal    Started            pod/quiz   Started container mongo
19s         Normal    Killing            pod/quiz   Stopping container quiz-api
19s         Normal    Killing            pod/quiz   Stopping container mongo
16s         Normal    Scheduled          pod/quiz   Successfully assigned chp08-set823/quiz to worker1
12s         Normal    Pulled             pod/quiz   Container image "georgebaptista/quiz-api:0.1" already present on machine
12s         Normal    Created            pod/quiz   Created container quiz-api
12s         Normal    Started            pod/quiz   Started container quiz-api
12s         Normal    Pulled             pod/quiz   Container image "mongo:5" already present on machine
12s         Normal    Created            pod/quiz   Created container mongo
12s         Normal    Started            pod/quiz   Started container mongo
```