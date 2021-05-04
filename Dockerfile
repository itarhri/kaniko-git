FROM gcr.io/kaniko-project/executor:debug as kaniko

FROM alpine
RUN apk update
RUN apk add bash git coreutils

COPY --from=kaniko /kaniko /kaniko

ENV HOME /root
ENV USER /root
ENV PATH $PATH:/kaniko
ENV SSL_CERT_DIR /kaniko/ssl/certs
ENV DOCKER_CONFIG /kaniko/.docker/
ENV DOCKER_CREDENTIAL_GCR_CONFIG /kaniko/.config/gcloud/docker_credential_gcr_config.json

ENTRYPOINT ["/kaniko/executor"]
