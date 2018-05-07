FROM alpine
MAINTAINER Ajay Reddy

RUN apk add --update alpine-sdk

COPY /Users/Shared/Jenkins/Home/workspace/MindStream-deployment-automation/cpp-ci-cd-example/bazel-bin/main/hello-world /

# have to use exec form as we have no shell to execute to execute our binary
CMD ["/hello-world"]
