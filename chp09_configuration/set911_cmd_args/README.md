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

### Events

```
kubectl get events -n=chp09-set911
LAST SEEN   TYPE     REASON      OBJECT      MESSAGE
7s          Normal   Scheduled   pod/kiada   Successfully assigned chp09-set911/kiada to main
7s          Normal   Pulled      pod/kiada   Container image "georgebaptista/kiada:0.4" already present on machine
7s          Normal   Created     pod/kiada   Created container kiada
6s          Normal   Started     pod/kiada   Started container kiada
4s          Normal   Killing     pod/kiada   Stopping container kiada
2s          Normal   Scheduled   pod/kiada   Successfully assigned chp09-set911/kiada to main
1s          Normal   Pulled      pod/kiada   Container image "georgebaptista/kiada:0.4" already present on machine
1s          Normal   Created     pod/kiada   Created container kiada
0s          Normal   Started     pod/kiada   Started container kiada
```