# 9.2.6 Understanding how configMap volumes work

### Objective

1. Understand technique of using subPath to mount individual file into a container

### Notes

Imagine you have a configMap volume that contains the file my-app.conf, and you want to add it to the /etc directory without losing any existing files in that directory. 

Instead of mounting the entire volume in /etc, you mount only the specific file using a combination of the mountPath and subPath fields, as shown in the following listing.

### Mechanism

```
spec:
containers:
- name: my-container
    volumeMounts:
    - name: envoy-config
	  subPath: envoy.yaml
	  mountPath: /etc/envoy.yaml


spec:
  volumes:
  # Definition of the configMap volume
  - name: envoy-config
    configMap:
      name: kiada-envoy-config
  containers:
  - name: kiada
    image: luksa/kiada:0.4
    imagePullPolicy: Always
    volumeMounts:
    - name: envoy-config
      subPath: envoy.yaml
      mountPath: /etc/envoy.yaml
      readOnly: true
```

### Reference

https://kubernetes.io/docs/concepts/storage/volumes/#using-subpath