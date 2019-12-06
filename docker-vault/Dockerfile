ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

ADD vault /usr/local/bin/
COPY files/run /usr/local/bin/run

ARG USER_UID=1000
RUN addgroup --gid ${USER_UID} user ;\
    adduser --home /home/user --uid ${USER_UID} --gid ${USER_UID} --disabled-password --disabled-login --gecos '' user

VOLUME /etc/vault
VOLUME /data/storage
VOLUME /data/logs

USER user

EXPOSE 8200

ENV LOGLEVEL=info

ENTRYPOINT ["/usr/local/bin/run"]
