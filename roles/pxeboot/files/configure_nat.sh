#!/bin/sh

firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o ens192 -j MASQUERADE
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i ens224 -o ens192 -j ACCEPT
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth1 -o ens224 -m state --state RELATED,ESTABLISHED -j ACCEPT

firewall-cmd --permanent --zone=internal --add-port=53/udp
firewall-cmd --permanent --zone=internal --add-port=67/udp
firewall-cmd --permanent --zone=internal --add-port=69/udp
firewall-cmd --permanent --zone=internal --add-port=123/udp
firewall-cmd --reload

