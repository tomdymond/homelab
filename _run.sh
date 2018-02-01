eval $(ssh-agent)
ssh-add id_rsa

case $1 in 
  tunnel)
    HOSTS_FILE="ansible/hosts-tunnel"
    ;;
  *)
    HOSTS_FILE="ansible/hosts"
    ;;
esac


echo ansible-playbook -i ${HOSTS_FILE} --vault-password-file=~/.ansible_vault_password ansible/pxe.yml $@

