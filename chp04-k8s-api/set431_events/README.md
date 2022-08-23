# 4.2.2 The Event object

## Objectives
1. Monitor events to learn of any problems arising in the cluster
2. Explore the Event object

---

## Notes

Events are represented by Event objects that are created and read via the Kubernetes API. 

Event objects contain information about what happened to the object and what the source of the event was.

Each Event object is deleted one hour after its creation to reduce the burden on etcd, the data store for Kubernetes API objects.