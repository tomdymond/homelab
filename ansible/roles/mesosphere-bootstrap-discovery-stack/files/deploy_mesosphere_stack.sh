#!/bin/sh

DEPLOY_STACK=${1}

source /etc/boot_environment;
eval export $(echo $USER_VARIABLES | tr '!' ' ');

MAXWAIT=300
while true; do 
  if [ -f /etc/bootstrap_ip ]; then
    export DCOS_BOOTSTRAP=$(</etc/bootstrap_ip)
    if curl --head http://${DCOS_BOOTSTRAP} >/dev/null 2>&1; then 
      /usr/bin/ansible-pull -vvv --vault-password-file=/root/.ansible_vault_password -C master -d /home/ansible/deploy -i /home/ansible/hosts -U https://github.com/tomdymond/homelab.git ansible/mesosphere-stack.yml | tee -a /tmp/ansible-mesosphere-deploy.out
    fi 
    exit 0
  fi
  sleep 1
done
echo "Gave up waiting for bootstrap_ip or http server connection" | tee -a /tmp/mesosphere-deploy.log

exit 1
