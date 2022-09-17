# 11.3.2 Introducing the EndpointSlice object

### Objective

1. Explore the EndpointSlice mechanism.


### Notes

An Endpoints object can contain multiple endpoint subsets, but each EndpointSlice contains only a single endpoint subset. 

An EndpointSlice object supports a maximum of 1000 endpoints, but by default Kubernetes only adds up 100 endpoints to each slice.

The number of ports in a slice is also limited to 100. 

So, service with hundreds of endpoints or ports can have multiple EndpointSlice objects associated with it. 

Like Endpoints, EndpointSlices are created and managed automatically.