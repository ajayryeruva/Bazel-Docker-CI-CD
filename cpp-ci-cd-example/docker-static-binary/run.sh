#!/bin/bash

echo 1. Building our run environment:
/usr/local/bin/docker build run -f run/Dockerfile -t hello-world:1.0
echo -e "\n"

echo 2. Running our runtime environment:
/usr/local/bin/docker run --rm hello-world:1.0 /bin/bash -c "/hello-world"
echo -e "\n"

echo 3. Binary size:
ls -lrth ${WORKSPACE}/cpp-ci-cd-example/bazel-bin/main/hello-world
