# 12.2.4 Setting the default backend


### Objective

1. Configure a default backend to which the ingress should forward the request if no rules can be matched. This default backend serves as a catch-all rule.

### Notes

This is a very common set-up for most web-applications.

### Implementation

We create a service called `fun404` to serve as the default backend.