# 11.6.3 Implementing real-world readiness probes


### Objective

1. Explore readiness probes via real-world examples


### Notes

* Use readinessProbe in YAML manifest:

```
readinessProbe:
  failureThreshold: 1
  httpGet:
    port: 80
    path: /quote
    scheme: HTTP
```

* Use dedicated endpoints in application:

```
/healthz/ready
```