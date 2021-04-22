ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

COPY files/hashicorp-vault-archive.gpg /etc/apt/trusted.gpg.d/
COPY files/vault.list /etc/apt/sources.list.d/

RUN apt-get update; \
    apt-get install --no-install-recommends -y vault; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge

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
