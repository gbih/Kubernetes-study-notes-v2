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

The two most important parts of an object are the Spec and Status sections.

We mainly write to the Spec section, which is where they specify the desired state of the object. 

For example, for pods the spec is where we specify the pod's containers, storage volumes, etc.

---

**Spec and Status sections**

Users write the Spec and read the Status. It is the Kubernetes Control plane that reads the Spec and then writes the Status.

The Kubernetes Control plane has components called controllers that manage the objects created by the user. Each controller reads the desired object state from the object's Spec section, performs the actions required to achieve this state, and reports back the state of the object by writing to its Status section. 