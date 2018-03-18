FROM alpine:3.4
RUN apk --no-cache add dnsmasq
EXPOSE 53 53/udp

ADD 10-consul /etc/dnsmasq.d/10-consul 
ADD dnsmasq.conf /etc/dnsmasq.conf
ENTRYPOINT ["dnsmasq", "-k"]


