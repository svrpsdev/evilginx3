FROM golang:1.21-alpine AS builder
RUN apk add --no-cache git make
WORKDIR /app
COPY . .
RUN make build

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /root
COPY --from=builder /app/evilginx2 /usr/local/bin/evilginx2
RUN mkdir -p /root/.evilginx
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 80 443
ENTRYPOINT ["/entrypoint.sh"]
