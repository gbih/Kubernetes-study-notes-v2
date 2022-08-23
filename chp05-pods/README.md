# Study Notes for Kubernetes In Action, v2

## Chapter 5: Running workloads in Pods

### Objectives
- Understanding how and when to group containers
- Run an app by creating a Pod object from a YAML file
- Adding a sidecar container to extend the pod's main container
- Initialize pods by running init containers at pod startup

### Notes

A pod is a co-located group of containers and the basic building block in Kubernetes. 

Instead of deploying containers individually, you deploy and manage a group of containers as a single unit, a pod. 

Although pods may contain several, it's not uncommon for a pod to contain just a single container. 

When a pod has multiple containers, all of them run on the same worker node, a single pod instance never spans multiple nodes.