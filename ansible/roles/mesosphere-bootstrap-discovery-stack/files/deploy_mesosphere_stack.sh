#!/bin/sh

DEPLOY_STACK=${1}
LOGFILE=/tmp/ansible-mesosphere-deploy.out

source /etc/boot_environment;
eval export $(echo $USER_VARIABLES | tr '!' ' ');

MAXWAIT=900
while true; do 
  if [ -f /etc/bootstrap_ip ]; then"
    export DCOS_BOOTSTRAP=$(</etc/bootstrap_ip)
    echo "Found bootstrap ip: ${DCOS_BOOTSTRAP}"
    if curl --head http://${DCOS_BOOTSTRAP} >/dev/null 2>&1; then
      echo "Successfully connected to HTTP server on bootstrap node"
      echo "Running ansible playbook. Logging output to ${LOGFILE}"
      /usr/bin/ansible-pull -vvv --vault-password-file=/root/.ansible_vault_password -C master -d /home/ansible/deploy -i /home/ansible/hosts -U https://github.com/tomdymond/homelab.git ansible/mesosphere-stack.yml | tee -a ${LOGFILE}
    fi 
    exit 0
  fi
  sleep 1
done
echo "Gave up waiting for bootstrap_ip or http server connection" | tee -a ${LOGFILE}

exit 1
