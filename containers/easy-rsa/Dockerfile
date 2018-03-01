FROM alpine:latest

RUN apk add --no-cache ca-certificates
RUN apk add --no-cache --virtual .fetch-deps openssl git openssl

RUN cd /usr/share && git clone https://github.com/OpenVPN/easy-rsa

ADD entrypoint.sh /
RUN chmod 755 /entrypoint.sh

VOLUME /easy-rsa/

ENTRYPOINT ["/entrypoint.sh"]

