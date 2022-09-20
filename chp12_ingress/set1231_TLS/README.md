# 12.3.1 Configuring the Ingress for TLS passthrough


### Objective

1. Explore a standard approach to terminate TLS connections at the ingress proxy.

### Notes

* Terminating TLS connections is a standard feature provided by most Ingress controllers.

### Implementation

* In general, it is better to do most operations declatively via YAML manifests, but in this case that would imply embedding the tls data, which we don't want. Instead, it may be more secure to run this operation via CLI.

* When using git, make sure to not include example.key nor example.crt