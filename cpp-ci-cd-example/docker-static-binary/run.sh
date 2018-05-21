#!/bin/bash

echo 1. Building our run environment:
sudo /usr/bin/docker build run -f run/Dockerfile -t mindstreamorg/hello-world:1.0
echo -e "\n"

docker tag mindstreamorg/hello-world:1.0 mindstreamorg/hello-world:$(git rev-parse --short HEAD)

echo 2. Pushing the docker image to Dockerhub:
sudo /usr/bin/docker push mindstreamorg/hello-world:$(git rev-parse --short HEAD)
echo -e "\n"

echo 3. Running our runtime environment:
sudo docker run --rm mindstreamorg/hello-world:$(git rev-parse --short HEAD) /bin/sh -c "./hello-world"
echo -e "\n"

echo 4. Binary size:
sudo ls -lrth ${WORKSPACE}/cpp-ci-cd-example/bazel-bin/main/hello-world
echo -e "\n"

echo 5. Cleanup Docker containers:
sudo docker rm -f $(sudo docker ps -a)
echo -e "\n"

echo 5. Cleanup Docker images:
sudo docker rmi -f $(sudo docker images)
echo -e "\n"
