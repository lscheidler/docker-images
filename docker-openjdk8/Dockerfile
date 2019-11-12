ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=stretch
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

ARG DISTRIBUTION=stretch

RUN apt-get update; \
    apt-get install -t ${DISTRIBUTION} -y openjdk-8-jdk-headless; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge

RUN echo LANG="en_US.UTF-8" >> /etc/default/locale ;\
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen ;\
    dpkg-reconfigure -u -f noninteractive locales ;\
    sed -i -e "s/^\(assistive_technologies\)/#\1/g" /etc/java-*-openjdk/accessibility.properties

ENV LANG=en_US.UTF-8
