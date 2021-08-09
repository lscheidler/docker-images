ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
ARG  VARIANT=openjdk11
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${VARIANT}-${CODE_VERSION}

ARG DISTRIBUTION=buster

RUN apt-get update; \
    apt-get install -t ${DISTRIBUTION} -y gradle; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old

ARG USER_UID=1000
RUN addgroup --gid ${USER_UID} user ;\
    adduser --home /home/user --uid ${USER_UID} --gid ${USER_UID} --disabled-password --disabled-login --gecos '' user

USER user

RUN mkdir /home/user/.gradle
VOLUME /home/user/.gradle

WORKDIR /home/user/workspace
ENTRYPOINT ["/usr/bin/gradle", "--no-daemon"]
