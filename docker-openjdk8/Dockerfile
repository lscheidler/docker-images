ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
FROM ${LOCAL_REPOSITORY}:debian-stretch-${CODE_VERSION}

RUN apt-get update; \
    apt-get install -t stretch -y openjdk-8-jdk-headless; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge
