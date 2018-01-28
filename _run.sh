eval $(ssh-agent)
ssh-add id_rsa

ansible-playbook -i hosts --vault-password-file=vault_password pxe.yml $@
