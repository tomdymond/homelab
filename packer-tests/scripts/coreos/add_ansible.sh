#!/bin/bash -eux

# Install Ansible.

ssh-keygen -f ${HOME}/.ssh/id_rsa -t rsa -N ''
cp -v ${HOME}/.ssh/id_rsa.pub ${HOME}/.ssh/authorized_keys

mkdir -pv ${HOME}/bin

cat << EOF > ${HOME}/bin/ansible-playbook-docker
docker run -v ${HOME}/.ssh:/root/.ssh -v $(pwd)/playbooks:/ansible/playbooks tomdymond/ansible:alpine-3 \$@
EOF

chmod 0755 ${HOME}/bin/ansible-playbook-docker

