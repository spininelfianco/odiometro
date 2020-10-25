#!/bin/bash
source /scripts/bash_functions.sh

## Entry instructions

wait_for_db "${APP_DATABASE_HOST}" "3306"

exec "$@"
