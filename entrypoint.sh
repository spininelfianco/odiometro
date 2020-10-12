#!/bin/bash

source bash_functions.sh

wait_for_db() {
  if ! [[ -n $SKIP_DB_WAIT && $SKIP_DB_WAIT -gt 0 ]]
  then
    local host=$1
    local port=$2
    local ip_address
    ip_address=$(getent hosts "$1" | awk '{ print $1 }')

    info "Connecting to at $host server at $ip_address:$port."

    counter=0
    until nc -z "$ip_address" "$port"; do
      counter=$((counter+1))
      if [ $counter == 10 ]; then
        error "Couldn't connect to $host server."
        return 1
      fi
      info "Trying to connect to $host server at $ip_address:$port. Attempt $counter."
      sleep 5
    done
    info "Connected to $host server."
  fi
}

## Entry instructions

wait_for_db "${APP_DATABASE_HOST}" "3306"

exec "$@"
