# 3.3.2 Exposing applications externally via Service object

## Objectives
1. Make a pod accessible externally by creating a Service object to expose it.

---

## Notes

* Several types of Service objects exist. 
* Some services expose pods only within the cluster, while others expose them externally. 
* A service with the type LoadBalancer provisions an external load balancer, which makes the service accessible via a public IP. 

