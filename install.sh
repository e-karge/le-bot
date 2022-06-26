
set -e || exit
set -x -o pipefail

adduser -h /run/tinydns -s /bin/nologin -u 53 -DH tinydns

apk --no-cache upgrade
apk --no-cache add dumb-init su-exec tinydns acme.sh

adduser -h /run/lebot -s /bin/nologin -u 8022 -DH lebot
install -d -o lebot -g lebot -m 00750 /run/lebot
install -d -o lebot -g lebot -m 00750 /run/lebot/dns
install -d -o lebot -g lebot -m 00750 /etc/lebot
install -d -o lebot -g lebot -m 00755 /var/db/lebot

addgroup root lebot
addgroup tinydns lebot

install -o lebot -g lebot -m 00640 /dev/null /run/lebot/dns/data
( cd /run/lebot/dns/; ls -ld . ; su-exec lebot tinydns-data )
