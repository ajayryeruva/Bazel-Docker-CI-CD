#FROM alpine
FROM centos:7
MAINTAINER Ajay R

#RUN apk add --update alpine-sdk

COPY ./hello-world /

# have to use exec form as we have no shell to execute to execute our binary
CMD ["/hello-world"]
