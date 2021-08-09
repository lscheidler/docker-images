ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=stretch
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-jmxtrans-agent-${CODE_VERSION}

#VOLUME /data/app
VOLUME /data/app/conf
VOLUME /data/app/logs

ARG DISTRIBUTION=stretch
RUN apt-get update; \
    apt-get install --no-install-recommends -t ${DISTRIBUTION}-backports -y libtcnative-1; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old

RUN addgroup --gid 1025 app ;\
    adduser --home /data/app --uid 1025 --gid 1025 --disabled-password --disabled-login --gecos '' app ;\
    chown app. -R /data/app

USER app

COPY files/run.sh /usr/local/bin/run.sh

WORKDIR /data/app

ENV JAVA_OPTS="" \
    JAVA_DEFAULT_OPTS="-XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+PrintGCDetails -Xloggc:logs/gc.%p.log -XX:+UseG1GC -XX:+UseStringDeduplication -XX:+PrintStringDeduplicationStatistics" \
    JMXTRANS_AGENT_ENABLED="false" \
    GRAPHITE_HOSTNAME="" \
    GRAPHITE_PORT="" \
    GRAPHITE_NAME_PREFIX="" \
    JAVA_MAX_HEAP="128m" \
    JAVA_ADDITIONAL_1="" \
    JAVA_ADDITIONAL_2="" \
    JAVA_ADDITIONAL_3="" \
    JAVA_ADDITIONAL_4="" \
    JAVA_ADDITIONAL_5="" \
    JAVA_ADDITIONAL_6="" \
    JAVA_ADDITIONAL_7="" \
    JAVA_ADDITIONAL_8="" \
    JAVA_ADDITIONAL_9=""
ENTRYPOINT ["/usr/local/bin/run.sh"]
