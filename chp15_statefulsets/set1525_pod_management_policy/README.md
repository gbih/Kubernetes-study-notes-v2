# 15.2.5 Using the OrderedReady Pod management policy

### Objective

1. Explore the use of OrderedReady Pod management policy


### Notes

Some stateful workloads cannot handle the controller creating all Pods at the same time. In this case, we can create pods one by one, via the podManagementPolicy set to OrderedReady.