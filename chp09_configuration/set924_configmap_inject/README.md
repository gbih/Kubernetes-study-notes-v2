# 9.2.4 Injecting config map entries into containers as files

### Objective

1. Inject a configmap into a container via the special `configMap` volume type.

### Notes

* The amount of information that can fit in a config map is limited by etcd. For now, the max size is around 1MB.

* A `configMap` volume makes the config map entries available as individual files. 
