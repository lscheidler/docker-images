#!/bin/bash

db_migrate() {
  /usr/bin/nodejs node_modules/.bin/sequelize db:migrate
}
if [ "$RUN_SEQUELIZE_MIGRATION" == "true" ] && [ -f "node_modules/.bin/sequelize" ] ; then
  db_migrate
fi

case "$1" in
  db:migrate)
    db_migrate
    ;;
  *)
    /usr/bin/nodejs app.js
    ;;
esac
