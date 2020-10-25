#!/bin/bash

echo '-------------------------------------------------------'

service mysql restart
#mysqld
# service --help

exec /scripts/init_from_DBNAMES.sh

## Entry instructions

# wait_for_db "${APP_DATABASE_HOST}" "3306"

exec "$@"
