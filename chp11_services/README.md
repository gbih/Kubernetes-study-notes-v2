# Study Notes for Kubernetes In Action, v2

## Chapter 11: Exposing Pods with Services

### Objectives
- Communication between pods
- Distributing client connections over a group of pods providing the same service
- Discovering services in the cluster through DNS and environment variables
- Exposing services to clients outside the cluster
- Using readiness probes to add or remove individual pods from services

### Notes

A Kubernetes Service is an object you create to provide a single, stable access point to a set of pods that provide the same service. 

Each service has a stable IP address that doesn't change for as long as the service exists. 

Clients open connections to that IP address on one of the exposed network ports, and those connections are then forwarded to one of the pods that back that service. 

In this way, clients don't need to know the addresses of the individual pods providing the service, so those pods can be scaled out or in and moved from one cluster node to the other at will. 

A service acts as a load balancer in front of those pods