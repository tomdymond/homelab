FROM alpine:3.4

RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk add --update keepalived iproute2 grep bash sed curl && \
    rm -f /var/cache/apk/* /tmp/*

COPY keepalived.sh /usr/bin/keepalived.sh
COPY keepalived.conf /etc/keepalived/keepalived.conf

RUN chmod +x /usr/bin/keepalived.sh

# Unfortunately, we must run as root

ENTRYPOINT ["/usr/bin/keepalived.sh"]
