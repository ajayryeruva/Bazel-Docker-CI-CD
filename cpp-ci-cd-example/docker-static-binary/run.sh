#!/bin/bash

echo 1. Building our run environment:
sudo /usr/bin/docker build run -f run/Dockerfile -t mindstreamorg/hello-world:1.0
echo -e "\n"

echo 2. Pushing the docker image to Dockerhub:
sudo /usr/bin/docker push mindstreamorg/hello-world:1.0
echo -e "\n"

echo 3. Running our runtime environment:
/usr/bin/docker run --rm mindstreamorg/hello-world:1.0 sh -c "/hello-world"
echo -e "\n"

echo 4. Binary size:
sudo ls -lrth ${WORKSPACE}/cpp-ci-cd-example/bazel-bin/main/hello-world
