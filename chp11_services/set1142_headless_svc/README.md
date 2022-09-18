# 11.4.2 Using headless services to connect to pods directly


### Objective

1. Explore mechanism where client can connect to pods directly

### Notes

* We can use the Kubernetes DNS to allow direct connections between clients and pods.

* We create a headless service which configures the internal DNS to return the pod IPs instead of the service's cluster IP.

* In a headless service, the cluster DNS returns not just a single A record pointing to the service's cluster IP, but multiple A records, one for each pod that's part of the service.

* Here, clients can then query the DNS to get the IPs of all the pods in the service.

