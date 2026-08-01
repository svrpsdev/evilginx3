FROM golang:1.22-alpine AS builder
RUN apk add --no-cache git
WORKDIR /app
COPY . .
RUN go build -mod=mod -o evilginx2 .

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /root
COPY --from=builder /app/evilginx2 /usr/local/bin/evilginx2
COPY --from=builder /app/phishlets ./phishlets
COPY --from=builder /app/redirectors ./redirectors
RUN mkdir -p /root/.evilginx
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 80 443
ENTRYPOINT ["/entrypoint.sh"]
