# Study Notes for Kubernetes In Action, v2

## Chapter 4: Introducing Kubernetes API objects

### Objectives
- Explore Kubernetes API mechanism
- Understand the YAML of Kubernetes objects
- Inspect the cluster object

### Notes

- Most K8s object manifests have these 4 sections:
	1. Type Metadata
	2. Object Metadata
	3. Spec
	4. Status

We mainly write to the Spec section, which is where they specify the desired state of the object. 

For example, for pods the spec is where we specify the pod's containers, storage volumes, etc.