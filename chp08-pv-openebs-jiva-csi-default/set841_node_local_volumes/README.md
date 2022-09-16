# 8.4.1 Creating local persistent volumes

### Objective

1. Explore attaching a disk to a specific cluster node

### Notes

* We get this error when using local persistent volume with main/worker nodes on the micro8s cluster:

```
FailedScheduling       pod/mongodb-local                       

0/2 nodes are available: 2 node(s) didn't find available persistent volumes to bind. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
```


### Directions

1. Run `SETUP_WORKER.sh` first, logged outside of the node instances (this calls multipass).
2. Then run `RUN.sh` while logged into the main node.

### Events

```
kubectl get events -n=chp08-set841
LAST SEEN   TYPE      REASON                OBJECT                                  MESSAGE
58s         Warning   FailedScheduling      pod/mongodb-local                       0/2 nodes are available: 2 node(s) didn't find available persistent volumes to bind. preemption: 0/2 nodes are available: 2 Preemption is not helpful for scheduling.
13s         Normal    WaitForPodScheduled   persistentvolumeclaim/quiz-data-local   waiting for pod mongodb-local to be scheduled
```