FROM alpine
RUN mkdir -p /etc/prom-conf/
ADD prometheus.yml.tpl /etc/prom-conf/prometheus.yml.tpl
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

