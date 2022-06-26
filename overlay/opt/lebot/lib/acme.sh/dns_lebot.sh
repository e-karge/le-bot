#!/bin/sh -x

dns_lebot_add() (
  set -e || return
  set -o pipefail

  fulldomain="$1"
  txtvalue="$2"

  echo ".$fulldomain" >> /run/lebot/dns/data
  echo "'$fulldomain:$txtvalue" >> /run/lebot/dns/data
  ( cd /run/lebot/dns; tinydns-data; )
)

dns_lebot_rm() (
  set -e || return
  set -o pipefail

  fulldomain="$1"
  txtvalue="$2"

  sed -i "/^'${fulldomain//./[.]}:$txtvalue/ d" /run/lebot/dns/data
  sed -i "/^[.]${fulldomain//./[.]}/{x;/^$/{s/^/-/;x;d};x;}" /run/lebot/dns/data
  ( cd /run/lebot/dns; tinydns-data; )
)
