#!/bin/bash
set -Eo pipefail

LOCAL_PORT="$API_PORT"
# shellcheck disable=SC2153
PUBLISHED_PORT="$SOCAT_PORT"
_RESTART="$SSH_RESTART"

while true; do
	printf "Forking :::%d onto 0.0.0.0:%d > trading mode %s \n" \
		"${LOCAL_PORT}" "${PUBLISHED_PORT}" "${TRADING_MODE}"
	socat TCP4-LISTEN:"${PUBLISHED_PORT}",fork,reuseaddr TCP4:127.0.0.1:"${LOCAL_PORT}"
	sleep "${_RESTART:-5}"
done
