#!/bin/bash
set -e
source /scripts/bash_functions.sh

## Entry instructions

info "Wait for $APP_DATABASE_HOST:3306"
wait_for_db 10 "/usr/bin/nc -z ${APP_DATABASE_HOST} 3306" "${APP_DATABASE_HOST}" "3306"

exec "$@"
