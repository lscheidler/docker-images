ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-openjdk11-${CODE_VERSION}

ARG DISTRIBUTION=buster
RUN apt-get update; \
    apt-get install -y gzip tar ;\
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old

ADD dist/solr-small.tgz /opt

RUN rm -rf /opt/solr*/dist /opt/solr*/contrib /opt/solr*/example; \
    ln -s /opt/solr* /opt/solr

COPY files/solr.in.sh /etc/default/solr.in.sh
COPY files/solr.xml files/solr.metrics.xml /etc/solr/
COPY files/run.sh /usr/local/bin/
ENV SOLR_INCLUDE=/etc/default/solr.in.sh SOLR_HEAP="1024m" GRAPHITE_HOST="" GRAPHITE_NAME_PREFIX="" METRICS_INTERVAL=""

ARG USER_UID=1000
RUN addgroup --gid ${USER_UID} app; \
    adduser --home /data/app --uid ${USER_UID} --gid ${USER_UID} --disabled-password --disabled-login --gecos '' app; \
    mkdir -p /data/app/conf /data/app/data /data/app/logs; \
    chown app. -R /data/app/

VOLUME /data/app/conf /data/app/data /data/app/logs

USER app

EXPOSE 8983
CMD /usr/local/bin/run.sh
