#!/usr/bin/env bash

sed -e "s/<certificate_base_name>/${CERTIFICATE_BASE_NAME}/g" -e "s/<endpoint_name>/${ENDPOINT_NAME}/g" -e "s/<endpoint_protocol>/${ENDPOINT_PROTOCOL}/g" -e "s/<endpoint_port>/${ENDPOINT_PORT}/g" /etc/nginx/sites-available/proxy.conf > /etc/nginx/sites-enabled/site.conf

/usr/sbin/nginx -g 'daemon off; master_process on;'
