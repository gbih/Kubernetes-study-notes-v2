# 11.3.1 Managing service endpoints


### Objective

1. Explore use cases where it can be useful to manually manage endpoints, as opposed to letting the Service object do it automatically.

### Notes

* Endpoints is a collection of endpoints that implement the actual service.

* A user does not create Endpoints directly. They are created automatically by Kubernetes when the associated Service objects are created.

* Each time a new pod appears or disappears that matches the Service's label selector, Kubernetes updates the Endpoints object to add or remove the endpoint associated with the pod. 