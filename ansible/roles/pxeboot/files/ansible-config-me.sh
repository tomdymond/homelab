#!/bin/bash

runuser -l ansible -c 'ansible-pull -C master -d /home/ansible/deploy -i /home/ansible/hosts -U https://github.com/tomdymond/homelab.git default-server.yml >> /home/ansible/run.log'

systemctl disable ansible-config-me.service
