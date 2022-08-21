#!/bin/bash
source ../../common/setup.sh
FULLPATH=$(pwd)

#####

echo $HR_TOP

echo "build -t kiada ./src"
docker build -t kiada ./src
enter


echo "docker images"
docker images
echo $HR


echo "docker run --name kiada-container -p 8080:8080 -d kiada"
docker run --name kiada-container -p 8080:8080 -d kiada
echo $HR


echo "docker ps"
docker ps
echo $HR


echo "curl localhost:8080"
curl localhost:8080
enter


# Add an additional tag for the image. The current name is kiada. We want to tag it as
# 
# ```bash
# <username>/kiada:<version>
# ``` 
echo "docker tag kiada georgebaptista/kiada:0.1"
docker tag kiada georgebaptista/kiada:0.1
echo "Done"
echo $HR


echo "docker images"
docker images
echo $HR


# If initial login to DockerHub, need to login with username/password, eg
echo "docker push georgebaptista/kiada:0.1"
docker push georgebaptista/kiada:0.1
enter


# Stop all containers
echo "docker stop $(docker ps -a -q)"
docker stop $(docker ps -a -q)
echo ""

# Remove all containers
echo "docker rm $(docker ps -a -q)"
docker rm $(docker ps -a -q)
echo ""

# Remove all images
echo "docker rmi $(docker images -a -q) --force"
docker rmi $(docker images -a -q) --force
echo ""

# Clean-up
# echo "docker system prune --force"
# docker system prune --force

echo $HR_TOP
