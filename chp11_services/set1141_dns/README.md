# 11.4.1 Understanding DNS records for Service objects


### Objective

1. Understand how Kubernetes looks up services via DNS.


### Tiny Tools image

The default giantswarm/tiny-tools image uses alpine which doesn't have bash, but only sh. Using bash is a bit more convenient, so build and use a modified version, using the official bash image:


```bash
docker build -t georgebaptista/tiny-tools-bash:0.1 ./

docker images

docker push georgebaptista/tiny-tools-bash:0.1
```