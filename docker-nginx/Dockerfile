ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=stretch
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

ARG DISTRIBUTION=stretch
RUN apt-get update; \
    apt-get install -t ${DISTRIBUTION} -y nginx-light; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge

RUN rm -f /etc/nginx/sites-enabled/*

COPY files/run.sh /usr/local/bin/run
COPY files/proxy.conf /etc/nginx/sites-available/
COPY files/static.conf /etc/nginx/sites-available/
COPY files/preferences.conf /etc/nginx/conf.d/

VOLUME /etc/ssl/private
VOLUME /var/www

ENV CERTIFICATE_BASE_NAME=wildcard ENDPOINT_NAME=backend ENDPOINT_PROTOCOL=http ENDPOINT_PORT=8080

ENTRYPOINT /usr/local/bin/run
