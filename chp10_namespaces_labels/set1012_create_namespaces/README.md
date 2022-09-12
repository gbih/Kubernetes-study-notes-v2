# 9.1.1 Setting the command and arguments

### Objective

1. Make the kiada applicatio configurable via command-line arguments and environment variables.

## Build and push image to Docker Hub

Make sure you have logged into Docker Hub from within the (Multipass) node.

```
docker build -t georgebaptista/kiada:0.4 ./

docker images

docker push georgebaptista/kiada:0.4
```