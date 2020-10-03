#!/bin/bash

# see master/4/debian-10/prebuildfs/opt/bitnami/base/functions
# from github.com/bitnami/bitnami-docker-express
[[ ${BASH_DEBUG:-false} = true ]] && set -x

# Constants
MODULE="$(basename "$0")"
BITNAMI_PREFIX=/opt/bitnami

# Color Palette
RESET='\033[0m'
BOLD='\033[1m'

## Foreground
BLACK='\033[38;5;0m'
RED='\033[38;5;1m'
GREEN='\033[38;5;2m'
YELLOW='\033[38;5;3m'
BLUE='\033[38;5;4m'
MAGENTA='\033[38;5;5m'
CYAN='\033[38;5;6m'
WHITE='\033[38;5;7m'

## Background
ON_BLACK='\033[48;5;0m'
ON_RED='\033[48;5;1m'
ON_GREEN='\033[48;5;2m'
ON_YELLOW='\033[48;5;3m'
ON_BLUE='\033[48;5;4m'
ON_MAGENTA='\033[48;5;5m'
ON_CYAN='\033[48;5;6m'
ON_WHITE='\033[48;5;7m'

# Functions

########################
# Print to STDERR
# Arguments:
#   Message to print
# Returns:
#   None
#########################
stderr_print() {
    printf "%b\\n" "${*}" >&2
}

########################
# Log message
# Arguments:
#   Message to log
# Returns:
#   None
#########################
log() {
    stderr_print "${NAMI_DEBUG:+${CYAN}${MODULE:-} ${MAGENTA}$(date "+%T.%2N ")}${RESET}${*}"
}

# Log an 'info' message
# Arguments:
#   Message to log
# Returns:
#   None
#########################
info() {
    log "${GREEN}INFO ${RESET} ==> ${*}"
}

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

# migrate_db() {
#   if ! [[ -n $SKIP_DB_MIGRATE && $SKIP_DB_MIGRATE -gt 0 ]] && [[ -f .sequelizerc ]]; then
#     info "Applying database migrations (sequelize db:migrate)."
#     sequelize db:migrate
#   fi
# }

# add_nodemon_support() {
#   info "Adding nodemon npm module (dev)."
#   npm install nodemon --save-dev
#   sed -i 's;"start".*;"start": "node ./bin/www", "development": "nodemon ./bin/www";' package.json
# }

# install_packages() {
#   if ! dependencies_up_to_date; then
#     if ! [[ -n $SKIP_NPM_INSTALL && $SKIP_NPM_INSTALL -gt 0 ]] && [[ -f package.json ]]; then
#       info "Installing npm packages."
#       npm install
#     fi
#   fi
# }


## Entry instructions

wait_for_db "${APP_DATABASE_HOST}" "3306"

exec "$@"
