ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=stretch
#FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}
FROM 949872482830.dkr.ecr.eu-central-1.amazonaws.com/liventy:debian-${DISTRIBUTION}-${CODE_VERSION}

ARG DISTRIBUTION=stretch
RUN apt-get update; \
    apt-get install -t ${DISTRIBUTION} -y easy-rsa; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old

COPY files/run.sh /usr/local/bin/run

VOLUME /var/lib/easy-rsa
WORKDIR /var/lib/easy-rsa

ENV COMMON_NAME=ca.local
ENTRYPOINT ["/usr/local/bin/run"]
