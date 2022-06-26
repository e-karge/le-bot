#!/bin/sh

set -e || exit
set -o pipefail

install -d -o lebot -g lebot -m 02770 /run/lebot
install -d -o lebot -g lebot -m 02770 /run/lebot/dns
install -d -o lebot -g lebot -m 02770 /run/lebot/acme

cert_name="${1%.csr.pem}"
cert_name="${cert_name##*/}"

acme.sh \
  --home /opt/lebot/lib/acme.sh \
  --config-home /run/lebot/acme \
  --accountkey /etc/lebot/account/acme-account-key.pem \
  --cert-file "/var/db/lebot/$cert_name.certificate.pem" \
  --ca-file "/var/db/lebot/$cert_name.certificate-ca.pem" \
  --fullchain-file "/var/db/lebot/$cert_name.certificate-chain.pem" \
  --signcsr \
  --dns dns_lebot \
  --csr "$@"
