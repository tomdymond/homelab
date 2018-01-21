#!/bin/bash

cd /home/ansible

git clone https://github.com/tomdymond/home.git

cd home/dev/ansible-boostrap/

runuser -l ansible -c 'ansible-playbook -i /home/ansible/hosts '
su ansible ansible-playbook -i /home/ansible/hosts baseconfig.yml

runuser -l ansible -c 'ansible-pull -C master -d /home/ansible/deploy -i /home/ansible/hosts -U https://github.com/tomdymond/home.git --purge &gt;&gt; /home/ansible/run.log'

systemctl disable ansible-config-me.service
