ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  TOMCAT=tomcat8
ARG  DISTRIBUTION=stretch
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${TOMCAT}-${CODE_VERSION}

ARG DISTRIBUTION=stretch
RUN apt-get update; \
    apt-get install --no-install-recommends -t ${DISTRIBUTION} -y service-wrapper pwgen; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old

COPY files/tomcat-wrapper /data/app/wrapper/app/bin/
COPY files/context.xml files/logging.properties files/server.xml files/web.xml files/wrapper.conf files/jmxtrans-agent.xml /data/app/wrapper/app/conf/
COPY files/defaults /etc/default/app

ARG USER_UID=1000
RUN addgroup --gid ${USER_UID} app ;\
    adduser --home /data/app --uid ${USER_UID} --gid ${USER_UID} --disabled-password --disabled-login --gecos '' app ;\
    mkdir -p /data/app/wrapper/app/bin ;\
    mkdir -p /data/app/wrapper/app/endorsed ;\
    mkdir -p /data/app/wrapper/app/temp ;\
    mkdir -p /data/app/wrapper/app/work ;\
    mkdir -p /data/app/data/app ;\
    ln -s /data/app/data/app/logs /data/app/wrapper/app/logs ;\
    chown app. -R /data/app/

USER app

WORKDIR /data/app/data/app

VOLUME /data/app/data/app/conf
VOLUME /data/app/data/app/logs

ENV LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8" TZ="Europe/Berlin" \
    JAVA_INITMEMORY="512" JAVA_MAXMEMORY="1024" \
    JMX_ENABLED="false" JMX_PASSWORD_ENABLED="true" \
    NEWRELIC_AGENT_ENABLED="false" NEWRELIC_ENV="staging" \
    JMXTRANS_AGENT_ENABLED="false" GRAPHITE_HOSTNAME="localhost" GRAPHITE_PORT="2003" GRAPHITE_NAME_PREFIX="jmxagent.#hostname#."

EXPOSE 8080
CMD ["/data/app/wrapper/app/bin/tomcat-wrapper", "console"]
