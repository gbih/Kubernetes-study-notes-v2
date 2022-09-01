# 7.2.3 Sharing files between containers

### Objective

1. Use a volume by multiple main containers concurrently


### Notes:

* Our pod will have two containers.
* One container will periodically runs the fortune command to update the file where the quote is stored.
* The other container will run a Nginx server, and use the data defined by the container running fortune.


### Build Docker container

```
docker build -t georgebaptista/quote-writer:0.1 ./

docker images

docker push georgebaptista/quote-writer:0.1
```

