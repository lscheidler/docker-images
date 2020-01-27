ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=stretch
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-jmxtrans-agent-${CODE_VERSION}

ARG DISTRIBUTION=stretch
RUN apt-get update; \
    apt-get install --no-install-recommends -y libtcnative-1; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old; \
    localepurge

ADD tomcat7-small.tar.gz /opt

# fix permissions
RUN find /opt -type f | xargs chmod go+r ;\
    find /opt -type d | xargs chmod go+rx

RUN ln -s /opt/apache-tomcat* /usr/share/tomcat7

ENV TOMCAT=tomcat7
