# Study Notes for Kubernetes In Action, v2

1. Use multipass on OSX with microk8s.
2. Explore how to best use K8s in terms of MLOps.
3. Work through updated Kubernetes APIs.
4. Explore main concept of K8s, which is to automate the management of clusters.

* Original source material for Kubernetes In Action, V2
    - [Book](https://www.manning.com/books/kubernetes-in-action-second-edition)
    - [GitHub Repo](https://github.com/luksa/kubernetes-in-action-2nd-edition)

------------

## Outline

### Part 1: Introduction to Kubernetes

1. Introducing Kubernetes
2. [Understanding containers](chp02-intro)
3. [Deploying your first application](chp03-deployment)


### Part 2: Kubernetes API Objects
4. [Introducing Kubernetes API objects](chp04-k8s-api)
5. Running workloads in pods
6. Managing the pod lifecycle
7. Attaching storage volumes to pods
8. Persisting data in PersistentVolumes
9. Configuration via ConfigMaps, Secrets and the Downward API
10. Organizing objects using Namespaces and Labels
11. Exposing pods with Services
12. Exposing services with Ingress
13. Replicating pods with ReplicaSets
14. Managing pods with Deployments
15. Deploying stateful workloads with StatefulSets
16. Deploying specialized workloads with DaemonSets, Jobs, and CronJobs


### Part 3: Kubernetes Internals

17. Understanding the Kubernetes API in detail
18. Understanding the Control Plane components
19. Understanding the Cluster Node components
20. Understanding the internal operation of Kubernetes controllers


### Part 4: Managing Kubernetes
21. Deploying highly-available clusters
22. Managing the computing resources available to Pods
23. Advanced scheduling using affinity and anti-affinity
24. Automatic scaling using the HorizontalPod Autoscaler
25. Securing the API using Role-Based Access Control (RBAC)
26. Protecting cluster nodes
27. Securing network communication using NetworkPolicies
28. Upgrading, backing up, and restoring Kubernetes clusters
29. Adding centralized logging, metrics, alerting and tracing


### Part 5: Making the most of Kubernetes
30. Kubernetes development and deployments best practices
31. Extending Kubernetes with CustomResource Definitions and operators
