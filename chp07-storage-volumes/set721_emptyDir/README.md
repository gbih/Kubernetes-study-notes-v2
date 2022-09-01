# 7.1.2 Persisting files across container restarts

### Objective

1. Create a simple directory that allows the pod to store data for the duration of its life cycle. 

### Notes:

Two changes to the pod manifest are required:

1. An emptyDir volume must be added to the pod
2. The volume must be mounted into the container