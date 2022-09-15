# 7.1.1 Demonstrating the need for volumes

### Objective

1. Build a new service that requires its data to be persisted.
2. The pod that runs the services will contain a volume.

## Build and push image to Docker Hub

```
docker build app/ --target bin --output app/bin/ --platform linux

docker build -t georgebaptista/quiz-api:0.1 ./

docker images

docker push georgebaptista/quiz-api:0.1
```