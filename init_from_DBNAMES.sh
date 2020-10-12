#!/bin/bash

# To execute on MariaDB


wait_for_db() {
  if ! [[ -n $SKIP_DB_WAIT && $SKIP_DB_WAIT -gt 0 ]]
  then
    local host=$1
    local port=$2
    local ip_address
    ip_address=$(getent hosts "$1" | awk '{ print $1 }')

    printf "Connecting to at $host server at $ip_address:$port.\n"

    max_count=${3:-5}
    counter=0
    until nc -z "$ip_address" "$port"; do
      counter=$((counter+1))
      if [ $counter == $max_count ]; then
        error "Couldn't connect to $host server.\n"
        return 1
        # exit 1;
      fi
      printf "Trying to connect to $host server at $ip_address:$port. Attempt $counter.\n"
      sleep 5
    done
    printf "Connected to $host server."
  fi
}

## Entry instructions

# wait_for_db "127.0.0.1" "3306" 250
# service mariadb status
# mysqladmin -u"$MYSQL_ROOT_USER" ping

# exit 1;

wait_for_db "127.0.0.1" "3306"

# printf "MySQL database service reachable\n"



db_names=("${INIT_DB_NAMES//,/ }")

for db_name in "$db_names[@]"; do
    printf "Create database $db_name\n"
    mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "mysql" "CREATE DATABASE \`$db_name\` IF NOT EXISTS"
    mysql -u"$MYSQL_ROOT_USER" -p"$MYSQL_ROOT_PASSWORD" "$db_name" < /schemas/app-schema.sql
done

# Add convention:
#   - "DB_NAME.sql" for initDB files.
#   - 'IF NOT EXISTS' sql needs to be used in the script
#   - define desired databases as INIT_DB_NAMES="odiometro,amoreometro,.."
