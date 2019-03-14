ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
FROM ${LOCAL_REPOSITORY}:debian-stretch-jmxtrans-agent-${CODE_VERSION}

RUN apt-get update; \
    apt-get install --no-install-recommends -t stretch -y tomcat8-common libtcnative-1 junit4 libservlet3.1-java; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge
