#!/bin/sh

SNMP_DEVICE=${SNMP_DEVICE:-"192.168.1.10"}
SNMP_EXPORTER_IP=${SNMP_EXPORTER_IP:-"172.17.0.1"}

cat /etc/prom-conf/prometheus.yml.tpl | sed "s/%SNMP_DEVICE%/${SNMP_DEVICE}/g;s/%SNMP_EXPORTER_IP%/${SNMP_EXPORTER_IP}/g" > /etc/prom-conf/prometheus.yml

