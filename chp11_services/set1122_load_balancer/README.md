# 11.2.2 Exposing a service through an external load balancer


### Objective

1. Explore provisioning a load balancer service via the LoadBalancer type.

### Notes

* A load balancer stands in front of the nodes and handles the connections coming from clients.

* It routes each connection to the load balancer service by forwarding it to the node port on one of the nodes. 

* A LoadBalancer service type is an extension of the NodePort type, which makes the service accessible through these node ports.

* By pointing clients to the load balancer instead of directly to the node port, the client avoids any unhealthy nodes, as the load balancer forwards traffic only to healthy nodes.

* The load balancer also ensures that connections are distributed evenly across all nodes in the cluster.

### MetalDB

The LoadBalancer implementation we use for microk8s is MetalLB,
https://metallb.universe.tf/

Kubernetes does not offer an implementation of network load-balancers (Services of type LoadBalancer) for bare metal clusters. The implementations of Network LB that Kubernetes does ship with are all glue code that calls out to various IaaS platforms (GCP, AWS, Azure…). If you’re not running on a supported IaaS platform (GCP, AWS, Azure…), LoadBalancers will remain in the pending state indefinitely when created.

Bare metal cluster operators are left with two lesser tools to bring user traffic into their clusters, NodePort and externalIPs services. Both of these options have significant downsides for production use, which makes bare metal clusters second class citizens in the Kubernetes ecosystem.

MetalLB aims to redress this imbalance by offering a Network LB implementation that integrates with standard network equipment, so that external services on bare metal clusters also just work as much as possible.

### microk8s MetalDB

If LoadBalancer cannot be created via a YAML manifest on microk8s, it may be necessary to reinitiate the metallb-plugin:

```
microk8s disable metallb
```

Reenable metallb:

```
microk8s enable metallb [some IP-range]
```


### Accessing HTML page

On microk8s created via multipass, look for the IP address of the node.

```
main Running 192.168.64.15
```

Confirm the nodeport address, eg 80080: 

```
kiada   LoadBalancer   10.152.183.99    10.64.140.43   80:30080/TCP,443:30443/TCP   16s   app=kiada
```

Then, in the browser:

```
http://192.168.64.15:30080/html
```
