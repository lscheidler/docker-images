ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

COPY dist/mailslurper /opt/mailslurper
COPY files/run /usr/local/bin/run

ARG USER_UID=1000
RUN addgroup --gid ${USER_UID} user ;\
    adduser --home /home/user --uid ${USER_UID} --gid ${USER_UID} --disabled-password --disabled-login --gecos '' user ;\
    chown user. -R /opt/mailslurper

USER user

EXPOSE 2500
EXPOSE 8080
EXPOSE 8085

WORKDIR /opt/mailslurper

ENV WWW_ADDRESS="0.0.0.0" \
    WWW_PORT="8080" \
    SERVICE_ADDRESS="0.0.0.0" \
    SERVICE_PORT="8085" \
    SMTP_ADDRESS="0.0.0.0" \
    SMTP_PORT="2500"

ENTRYPOINT ["/usr/local/bin/run"]
