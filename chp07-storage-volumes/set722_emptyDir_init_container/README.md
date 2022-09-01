# 7.2.2 Populating an emptyDir volume with data using an init container

### Objective

1. Automatically populate the database when the pod starts.
2. Use an init container to initialize an emptyDir volume.


### Notes:

* The old, deprecated way was via gitRepo.

* As an alternative, we could use an emptyDir volume we initialize with an init container that executes the git clone command. However, this would mean that the pod must make a network call to fetch the data.

* A more generic approach of populating an emptyDir volume is to package the data into a container image and copy the data files from the container to the volume when the container starts. This removes the dependency on any external systems and allows the pod to run regardless of the network connectivity status.

### Build Docker container

```
docker build -t georgebaptista/quiz-initdb-script-installer:0.1 ./

docker images

docker push georgebaptista/quiz-initdb-script-installer:0.1
```

