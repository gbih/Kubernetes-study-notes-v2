# 5.5.2 Adding init containers to a pod

## Objectives
1. Run additional containers at pod startup



---

### Setup

* Add two init containers to the kiada pod.
	1. The first init container emulates an initialization procedure.
	2. The second init container performs a network connectivity test using the ping tool.


* Create two Docker images

1. Docker init-demo:

```
docker build -t init-demo ./docker_init_procedure --quiet && \
docker tag init-demo georgebaptista/init-demo && \
docker images && \
docker push georgebaptista/init-demo
```


2. Docker network-connectivity-checker

```
docker build -t network-connectivity-checker ./docker_init_network_checker --quiet && \
docker tag network-connectivity-checker georgebaptista/network-connectivity-checker && \
docker images && \
docker push georgebaptista/network-connectivity-checker
```
