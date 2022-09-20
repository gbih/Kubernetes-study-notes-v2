# 12.5.1 Using multiple ingress controllers


### Objective

1. Explore the relationship between ingress controllers and IngressClass objects

### Notes

* We specify the ingress controller through IngressClass objects.

* If multiple ingress controllers are installed in the cluster, a default IngressClass is marked via the annotation `"ingressclass.kubernetes.io/is-default-class":"true"`
