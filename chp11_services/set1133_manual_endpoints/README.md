# 11.3.3 Managing service endpoints manually


### Objective

1. Explore how to manage service endpoints manually by creating the Service object without a label selector.

2. In this case, we have to create the Endpoints object manually.


### Notes

We typically manage service endpoints this way when we want to make existing external service accessible to cluster pods under a different name. 

This way, the service can be found through the cluster DNS and enn vars.