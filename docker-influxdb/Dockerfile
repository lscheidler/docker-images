ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=stretch
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

ARG DISTRIBUTION=stretch
RUN apt-get update; \
    apt-get install -t ${DISTRIBUTION} -y influxdb; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old

EXPOSE 8083
EXPOSE 8086
ENV INFLUXD_OPTS=""
USER influxdb
VOLUME /var/lib/influxdb/
ENTRYPOINT /usr/bin/influxd -config /etc/influxdb/influxdb.conf $INFLUXD_OPTS
