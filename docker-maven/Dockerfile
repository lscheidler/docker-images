ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-openjdk11-${CODE_VERSION}

ARG DISTRIBUTION=buster

RUN apt-get update; \
    apt-get install -t ${DISTRIBUTION} -y maven; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge

ARG USER_UID=1000
RUN addgroup --gid ${USER_UID} user ;\
    adduser --home /home/user --uid ${USER_UID} --gid ${USER_UID} --disabled-password --disabled-login --gecos '' user

USER user

WORKDIR /home/user
