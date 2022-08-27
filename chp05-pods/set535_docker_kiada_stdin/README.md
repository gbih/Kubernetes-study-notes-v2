# 5.3.5 Attaching to a running container

## Objectives
1. Use kubectl attach to write to the application's standard input in the container.

---

## Notes

Using kubectl attach, we can send to stdin via pipe, then exit

```
IP=$(kubectl get pod -n=chp05-set535 -o jsonpath='{.items[0].status.podIP}')

date | kubectl attach kiada-stdin -i -n=chp05-set535

curl $IP:8080
```


### Reference

https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#attach


### Setup

Have to create a new Docker container with `stdin: true`. Name this new container `kiada-stdin`

Build Docker image and tag as `kiada-stdin`


```bash
docker build -t kiada-stdin ./src --quiet
```

```bash
docker tag kiada georgebaptista/kiada-stdin
```

```bash
docker images
```

```bash
docker push georgebaptista/kiada-stdin
```