#!/bin/sh

PUBLIC_INTERFACE="ens192"
PRIVATE_INTERFACES="ens224 ens256"

firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o ${PUBLIC_INTERFACE} -j MASQUERADE
for PRIVATE_INTERFACE in ${PRIVATE_INTERFACES}; do 
  firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i ${PRIVATE_INTERFACE} -o ${PUBLIC_INTERFACE} -j ACCEPT
  firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i ${PUBLIC_INTERFACE} -o ${PRIVATE_INTERFACE} -m state --state RELATED,ESTABLISHED -j ACCEPT
done

firewall-cmd --permanent --zone=internal --add-port=53/udp
firewall-cmd --permanent --zone=internal --add-port=67/udp
firewall-cmd --permanent --zone=internal --add-port=69/udp
firewall-cmd --permanent --zone=internal --add-port=123/udp
firewall-cmd --reload

