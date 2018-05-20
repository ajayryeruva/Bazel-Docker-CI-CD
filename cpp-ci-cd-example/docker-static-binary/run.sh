#!/bin/bash

echo 1. Building our run environment:
/usr/bin/docker build run -f run/Dockerfile -t mindstreamorg/hello-world:1.0
echo -e "\n"

echo 2. Pushing the docker image to Dockerhub:
/usr/bin/docker push mindstreamorg/hello-world:1.0
echo -e "\n"

echo 2. Running our runtime environment:
#/usr/bin/docker run --rm mindstreamorg/hello-world:1.0 sh -c "echo Hello World"
/usr/bin/docker run --rm mindstreamorg/hello-world:1.0
echo -e "\n"

echo 3. Binary size:
ls -lrth ${WORKSPACE}/cpp-ci-cd-example/bazel-bin/main/hello-world
