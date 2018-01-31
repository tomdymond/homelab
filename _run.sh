eval $(ssh-agent)
ssh-add id_rsa

ansible-playbook -i hosts --vault-password-file=~/.ansible_vault_password pxe.yml $@
