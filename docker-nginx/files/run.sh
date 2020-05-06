#!/usr/bin/env bash

enable_site() {
  sed \
      -e "s#<certificate_base_name>#${CERTIFICATE_BASE_NAME}#g" \
      -e "s#<endpoint_name>#${ENDPOINT_NAME}#g" \
      -e "s#<endpoint_protocol>#${ENDPOINT_PROTOCOL}#g" \
      -e "s#<endpoint_port>#${ENDPOINT_PORT}#g" \
      $1 > /etc/nginx/sites-enabled/site.conf
}

case "$MODE" in
  custom)
    enable_site /etc/nginx/sites-available/custom.conf
    ;;
  static)
    enable_site /etc/nginx/sites-available/static.conf
    ;;
  proxy)
    enable_site /etc/nginx/sites-available/proxy.conf
    ;;
esac

/usr/sbin/nginx -g 'daemon off; master_process on;'
