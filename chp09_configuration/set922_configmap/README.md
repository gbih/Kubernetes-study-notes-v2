# 9.2.2 Using a config map to decouple configuration from the pod

### Objective

1. Decouple the pod configuration from the pod manifest
2. Move the configuration into a ConfigMap object, which we then reference in the pod manifest.

### Notes

To keep applications Kubernetes-agnostic, pods typically do not read the ConfigMap object via the k8s REST API. Instead, the key/value pairs in the config map are passed to containers as environment variables, or mounted as files in the container's filesystem via a `configMap` volume.

### Mechanism

1. The config map contains a set of key-value pairs.
2. The key-value pairs from the config map are injected into the container's environment variables.
3. Each key-value pair is projected into the container's filesystem as a file. The key becomes the filename, while the value is written to the file.
