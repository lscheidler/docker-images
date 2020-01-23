ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

COPY mailslurper /opt/mailslurper

ARG USER_UID=1000
RUN addgroup --gid ${USER_UID} user ;\
    adduser --home /home/user --uid ${USER_UID} --gid ${USER_UID} --disabled-password --disabled-login --gecos '' user ;\
    chown user. -R /opt/mailslurper

USER user

EXPOSE 2500
EXPOSE 8080
EXPOSE 8085

WORKDIR /opt/mailslurper
ENTRYPOINT ["/opt/mailslurper/mailslurper"]
