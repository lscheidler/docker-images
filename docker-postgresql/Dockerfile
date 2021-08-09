ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

RUN apt-get update; \
    apt-get install --no-install-recommends -y postgresql-11; \
    pg_dropcluster 11 main; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old

COPY files/pg_hba.conf.sample /usr/share/postgresql/11/pg_hba.conf.sample
COPY files/run /usr/local/bin/
EXPOSE 5432

VOLUME /var/lib/postgresql/11

ENTRYPOINT ["/usr/local/bin/run"]
