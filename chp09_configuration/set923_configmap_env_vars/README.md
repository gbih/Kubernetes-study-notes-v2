# 9.2.3 Injecting config map values into environmental variables

### Objective

1. Use a config map in a pod.

### Mechanism

To inject a single config map entry into an environmental variable, replace the `value` field in the environment variable definition with the `valueFrom` field and refer to the config map entry.