# 11.3.2 Managing service endpoints manually


### Objective

1. Explore how to manage service endpoints manually by creating the Service object without a label selector.

2. In this case, we have to create the Endpoints object manually.

### Notes

Not all services are backed by pods. Endpoints to which a service forwards traffic can be anything that has an IP address.
