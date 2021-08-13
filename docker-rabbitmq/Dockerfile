ARG  LOCAL_REPOSITORY=local
ARG  CODE_VERSION=latest
ARG  DISTRIBUTION=buster
FROM ${LOCAL_REPOSITORY}:debian-${DISTRIBUTION}-${CODE_VERSION}

ARG USER_UID=1000
RUN addgroup --gid ${USER_UID} rabbitmq ;\
    adduser --home /var/lib/rabbitmq --uid ${USER_UID} --gid ${USER_UID} --disabled-password --disabled-login --gecos '' rabbitmq

RUN apt-get update; \
    apt-get install -y rabbitmq-server jq pwgen; \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y; \
    find /var/cache/apt -type f | xargs rm -f; \
    find /var/lib/apt/lists -type f | xargs rm -f; \
    find /usr/share/doc -mindepth 1 -maxdepth 1 | xargs rm -rf; \
    rm -rf /var/cache/debconf/*-old

COPY files/enabled_plugins /etc/rabbitmq/enabled_plugins
COPY files/rabbitmq.config /etc/rabbitmq/rabbitmq.config
COPY files/rabbitmq /usr/local/sbin/rabbitmq

USER rabbitmq
EXPOSE 15672
EXPOSE 5672

VOLUME /var/lib/rabbitmq
VOLUME /var/log/rabbitmq

ENV PROVISION_CONFIG="/var/lib/rabbitmq/config.json"
ENV RABBITMQ_DEFINITIONS="/var/lib/rabbitmq/rabbit.definitions.json"

WORKDIR /var/lib/rabbitmq
CMD /usr/local/sbin/rabbitmq
