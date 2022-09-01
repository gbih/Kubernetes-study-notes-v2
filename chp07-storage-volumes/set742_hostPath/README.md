# 7.4.2 Using a hostPath volume

### Objective

1. Demonstrate how dangerous hostPath volumes can be

### Notes

1. The hostPath volume allows a pod to access any path in filesystem of the worker node. This volume type is dangerous because it allows users to make changes to the configuration of the worker node and run any process they want on the node.