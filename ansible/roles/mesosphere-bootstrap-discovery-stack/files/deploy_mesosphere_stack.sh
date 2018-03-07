#!/bin/sh

DEPLOY_STACK=${1}

source /etc/boot_environment;
eval export $(echo $USER_VARIABLES | tr '!' ' ');

MAXWAIT=30
while true; do 
  if [ -f /etc/bootstrap_ip ]; then
    /usr/bin/ansible-pull -vvv --vault-password-file=/root/.ansible_vault_password -C master -d /home/ansible/deploy -i /home/ansible/hosts -U https://github.com/tomdymond/homelab.git ansible/mesosphere-stack.yml | tee -a /tmp/ansible-mesosphere-deploy.out
    exit 0
  fi
done

exit 1
