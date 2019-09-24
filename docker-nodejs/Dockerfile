ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
FROM ${LOCAL_REPOSITORY}:debian-stretch-${CODE_VERSION}

COPY files/nodesource.list /etc/apt/sources.list.d/nodesource.list
COPY files/nodesource.gpg /etc/apt/trusted.gpg.d/nodesource.gpg
COPY files/run.sh /usr/local/bin/

ARG DISTRIBUTION=stretch
RUN apt-get update; \
    apt-get install --no-install-recommends -t ${DISTRIBUTION} -y nodejs; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge

VOLUME /data/app/data/app

RUN addgroup --gid 1025 app ;\
    adduser --home /data/app --uid 1025 --gid 1025 --disabled-password --disabled-login --gecos '' app ;\
    chown app. -R /data/app/

USER app

WORKDIR /data/app/data/app/current

ENV RUN_SEQUELIZE_MIGRATION=true

ENTRYPOINT ["/usr/local/bin/run.sh"]
