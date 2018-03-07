FROM alpine:latest

RUN apk add --no-cache ca-certificates
RUN apk add --no-cache --virtual .fetch-deps python py-requests curl


ADD is_service_online.py /usr/bin
ADD entrypoint.sh /
ADD sample.json /tmp/sample.json
RUN chmod 0755 /usr/bin/is_service_online.py /entrypoint.sh

VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]

