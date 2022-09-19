# 12.2.1 Exposing a service through an Ingress


### Objective

1. Explore implementing an Ingress object to expose the kiada service.


### Notes

**Adding the Ingress IP to the DNS**

After adding an Ingress to a production cluster, you add a record to the DNS server. To enable external clients to access the service through the ingress, configure the DNS server to resolve the domain name `kiada.example.com` to the ingress IP .....


### Setup

```
gsed -i '' -e 's/set1162/set1163/g' `grep 'set1162' -rl *`
```