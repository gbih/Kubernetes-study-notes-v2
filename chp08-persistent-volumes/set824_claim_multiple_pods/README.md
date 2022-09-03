# 8.2.4 Using a PVC and PV in multiple pods

### Objective

1. Explore the nuances of using a PVC and PV in multiple pods


### Notes

1. ReadWriteOnce mode implies only a single node can attach the volume.
2. The word "Once" in ReadWriteOnce refers to nodes, not pods.

#### To-do

This material requires a multi-node environment to work through properly.