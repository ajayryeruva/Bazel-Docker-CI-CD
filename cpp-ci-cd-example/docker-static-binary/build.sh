#!/bin/bash

echo 0. Remove existing hello-world binary in workspace
rm ${WORKSPACE}/cpp-ci-cd-example/bazel-bin/main/hello-world

echo 1. Building our run environment:
docker build run -f run/Dockerfile -t hello-world:1.0
echo -e "\n"

echo 2. Running our runtime environment:
docker run --rm hello-world:1.0
echo -e "\n"

echo 3. Binary size:
ls -lrth ${WORKSPACE}/cpp-ci-cd-example/bazel-bin/main/hello-world
