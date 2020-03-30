ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

RUN apt-get update; \
    apt-get install --no-install-recommends -y mariadb-server; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge

RUN mkdir /run/mysql /run/mysqld; \
    chown mysql. /run/mysql /run/mysqld

COPY files/99-server.cnf /etc/mysql/mariadb.conf.d/99-server.cnf
COPY files/run /usr/local/bin/

EXPOSE 3306

VOLUME /var/lib/mysql

ENTRYPOINT ["/usr/local/bin/run"]
