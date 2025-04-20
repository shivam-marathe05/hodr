#!/bin/sh
set -e


echo "[$(date --iso-8601=seconds)] Starting Hodor (listening on $HOST_ADDR)…"
exec /usr/local/bin/hodor
