FROM gcr.io/kaniko-project/executor:debug as kaniko

FROM centos:7

RUN yum -y update; yum install git -q -y; rm -rf /var/cache /var/log/dnf* /var/log/yum.*;

COPY --from=kaniko /kaniko/executor /kaniko/
COPY --from=kaniko /kaniko/.docker /kaniko/.docker

ENV HOME /root
ENV USER /root
ENV PATH /usr/local/bin:/kaniko:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV SSL_CERT_DIR=/kaniko/ssl/certs
ENV DOCKER_CONFIG /kaniko/.docker/
WORKDIR /workspace

ENTRYPOINT ["/kaniko/executor"]
