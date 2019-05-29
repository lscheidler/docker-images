#!/bin/bash

if [ "${GRAPHITE_HOST}" != "" ] ; then
  cp /etc/solr/solr.metrics.xml /data/app/conf

  ADDITIONAL_CMD_OPTS="${ADDITIONAL_CMD_OPTS} -Dgraphite.host=${GRAPHITE_HOST}"
else
  cp /etc/solr/solr.xml /data/app/conf
fi

if [ "${GRAPHITE_NAME_PREFIX}" != "" ] ; then
  ADDITIONAL_CMD_OPTS="${ADDITIONAL_CMD_OPTS} -Dgraphite.namePrefix=${GRAPHITE_NAME_PREFIX}"
fi

if [ "${METRICS_INTERVAL}" != "" ] ; then
  ADDITIONAL_CMD_OPTS="${ADDITIONAL_CMD_OPTS} -Dmetrics.interval=${METRICS_INTERVAL}"
fi

/opt/solr/bin/solr start -f -a "${ADDITIONAL_CMD_OPTS}" $@
