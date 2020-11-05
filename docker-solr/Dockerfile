ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=stretch
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-openjdk8-${CODE_VERSION}

ARG DISTRIBUTION=stretch
RUN apt-get update; \
    apt-get install -y gzip tar ;\
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge

ADD dist/solr-small.tgz /opt

RUN rm -rf /opt/solr*/dist /opt/solr*/contrib /opt/solr*/example; \
    ln -s /opt/solr* /opt/solr

COPY files/solr.in.sh /etc/default/solr.in.sh
COPY files/solr.xml files/solr.metrics.xml /etc/solr/
COPY files/run.sh /usr/local/bin/
ENV SOLR_INCLUDE=/etc/default/solr.in.sh SOLR_HEAP="1024m" GRAPHITE_HOST="" GRAPHITE_NAME_PREFIX="" METRICS_INTERVAL=""

RUN addgroup --gid 1025 app; \
    adduser --home /data/app --uid 1025 --gid 1025 --disabled-password --disabled-login --gecos '' app; \
    mkdir -p /data/app/conf /data/app/data /data/app/logs; \
    chown app. -R /data/app/

VOLUME /data/app/conf /data/app/data /data/app/logs

USER app

EXPOSE 8983
CMD /usr/local/bin/run.sh
