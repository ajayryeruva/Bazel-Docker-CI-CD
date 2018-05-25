#!/bin/bash

echo 1. Building our run environment:
/usr/bin/docker build run -f run/Dockerfile -t mindstreamorg/hello-world:1.0
echo -e "\n"

echo 2. Tag Docker image:
/usr/bin/docker tag mindstreamorg/hello-world:1.0 mindstreamorg/hello-world:$(git rev-parse --short HEAD)
echo -e "\n"

echo 3. Pushing the docker image to Dockerhub:
/usr/bin/docker push mindstreamorg/hello-world:$(git rev-parse --short HEAD)
echo -e "\n"

echo 4. Running our runtime environment:
/usr/bin/docker run --rm mindstreamorg/hello-world:$(git rev-parse --short HEAD) /bin/sh -c "./hello-world"
echo -e "\n"

echo 5. Binary size:
ls -lrth ${WORKSPACE}/cpp-ci-cd-example/bazel-bin/main/hello-world
echo -e "\n"

echo 6. Cleanup Docker containers:
/usr/bin/docker rm -f $(sudo docker ps -a)
echo -e "\n"

echo 7. Cleanup Docker images:
/usr/bin/docker rmi -f $(sudo docker images)
echo -e "\n"
