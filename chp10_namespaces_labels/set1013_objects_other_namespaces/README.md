# 10.1.3 Managing objects in other namespaces

### Objective

1. Create namespaces both imperatively on CLI, and declaratively via YAML manifest file.

### Notes

The book lists this imperative manner:

```
kubectl apply -f kiada-ssl.yaml -n chp10-set1013
```

but it is much clearer to explicitly declare the namespace in the YAML manifest files of the respective Kubernetes objects.