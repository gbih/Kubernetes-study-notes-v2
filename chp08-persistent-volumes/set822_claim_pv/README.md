# 8.2.2 Claiming a persistent volume

### Objective

1. Claim a persistent volume via PersistentVolumeClaim (PVC) object.

### Notes

* Our cluster has two PVs, but before we can use them, we have to claim them via a PVC.

### Events

```
kubectl get events -n=chp08-set822                                                                         main: Thu Sep 15 14:14:51 2022

LAST SEEN   TYPE     REASON      OBJECT     MESSAGE
2m14s       Normal   Scheduled   pod/quiz   Successfully assigned chp08-set822/quiz to worker1
2m12s       Normal   Pulled      pod/quiz   Container image "luksa/quiz-api:0.1" already present on machine
2m12s       Normal   Created     pod/quiz   Created container quiz-api
2m12s       Normal   Started     pod/quiz   Started container quiz-api
2m12s       Normal   Pulled      pod/quiz   Container image "mongo:5" already present on machine
2m12s       Normal   Created     pod/quiz   Created container mongo
2m11s       Normal   Started     pod/quiz   Started container mongo
```