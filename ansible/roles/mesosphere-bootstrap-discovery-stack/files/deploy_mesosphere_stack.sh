#!/bin/sh

LOGFILE=/tmp/ansible-mesosphere-deploy.out

touch ${LOGFILE}

source /etc/boot_environment;
eval export $(echo $USER_VARIABLES | tr '!' ' ');

WAIT_COUNTER=0
MAXWAIT=3600

echo "Waiting for bootstrap ip"
while true; do
  if [ ${WAIT_COUNTER} -gt ${MAXWAIT} ]; then 
    echo "Gave up waiting for bootstrap_ip or http server connection" | tee -a ${LOGFILE}
    exit 2
  fi
  if [ -f /etc/bootstrap_ip ]; then
    export DCOS_BOOTSTRAP=$(</etc/bootstrap_ip)
    echo "Found bootstrap ip: ${DCOS_BOOTSTRAP}"
    if curl --head http://${DCOS_BOOTSTRAP} >/dev/null 2>&1; then
      echo "Successfully connected to HTTP server on bootstrap node"
      echo "Running ansible playbook. Logging output to ${LOGFILE}"
      /usr/bin/ansible-pull -vvv --vault-password-file=/root/.ansible_vault_password -C master -d /home/ansible/deploy -i /home/ansible/hosts -U https://github.com/tomdymond/homelab.git ansible/mesosphere-stack.yml | tee -a ${LOGFILE}
      exit 0
    fi 
  fi
  let WAIT_COUNTER++
  sleep 1
done

exit 1
