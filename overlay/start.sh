#!/bin/sh -e

IP=0.0.0.0 ROOT=/run/lebot/dns UID=53 GID=8022 tinydns &

exec /usr/sbin/crond -f -c /opt/lebot/lib/cron.d/
