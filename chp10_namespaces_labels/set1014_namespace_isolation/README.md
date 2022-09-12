# 10.1.4 Understanding the (lack of) isolation between namespaces

### Objective

1. Understand the runtime isolation between pods in different namespaces.

### Notes

* By default, there is no network isolation between namespaces. 

* Because namespaces don't provide true isolation, you should not use them to split a single physical Kubernetes cluster into the production, staging, and development environments. 

* Hosting each environment on a separate physical cluster is a much safer approach.
