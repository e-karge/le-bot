# le bot

Minimal Let's Encrypt ACME bot based on `cron`, `acme.sh` and `tinydns`


## Volumes

input: /etc/lebot
  - account key: /etc/lebot/account/acme-account-key.pem
  - requests: /etc/lebot/requests/*.csr.pem
output: /var/db/lebot
  - server certificate: /var/db/lebot/*.certificate.pem
  - CA certificate: /var/db/lebot/*.certificate-ca.pem
  - full certificate chain: /var/db/lebot/*.certificate-chain.pem
