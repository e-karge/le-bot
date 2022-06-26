#!/bin/sh

set -e || exit
set -x -o pipefail

for request in /etc/lebot/requests/*.csr.pem; do
  /opt/lebot/bin/sign-csr.sh "$request"
done
