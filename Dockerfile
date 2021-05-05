FROM gcr.io/kaniko-project/executor:debug as kaniko

FROM ghcr.io/oracle/oraclelinux:7-slim

RUN yum clean all
RUN yum update -y
RUN yum install git -q -y

COPY --from=kaniko /kaniko/executor /kaniko/
COPY --from=kaniko /kaniko/.docker /kaniko/.docker

ENV HOME /root
ENV USER /root
ENV PATH /usr/local/bin:/kaniko:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV SSL_CERT_DIR=/kaniko/ssl/certs
ENV DOCKER_CONFIG /kaniko/.docker/
WORKDIR /workspace

ENTRYPOINT ["/kaniko/executor"]
