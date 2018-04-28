#!/bin/bash -eux

## PREPARE PYTHON
PYPY_VERSION=5.1.0

if [[ -e ${HOME}/pypy-$PYPY_VERSION-linux64.tar.bz2 ]]; then
  tar -xjf ${HOME}/pypy-$PYPY_VERSION-linux64.tar.bz2
  rm -rf ${HOME}/pypy-$PYPY_VERSION-linux64.tar.bz2
else
  wget -O - https://bitbucket.org/pypy/pypy/downloads/pypy-${PYPY_VERSION}-linux64.tar.bz2 |tar -xjf -
fi

mv -n pypy-${PYPY_VERSION}-linux64 pypy

## library fixup
mkdir -p pypy/lib
ln -snf /lib64/libncurses.so.5.9 ${HOME}/pypy/lib/libtinfo.so.5

mkdir -p ${HOME}/bin

cat > ${HOME}/bin/python <<EOF
#!/bin/bash
LD_LIBRARY_PATH=${HOME}/pypy/lib:$LD_LIBRARY_PATH exec ${HOME}/pypy/bin/pypy "\$@"
EOF

chmod +x ${HOME}/bin/python
${HOME}/bin/python --version

touch ${HOME}/.bootstrapped

wget https://bootstrap.pypa.io/get-pip.py
${HOME}/bin/python get-pip.py

cat > ${HOME}/bin/pip << EOF
#!/bin/bash
LD_LIBRARY_PATH=${HOME}/pypy/lib:$LD_LIBRARY_PATH ${HOME}/pypy/bin/pip $@
EOF

chmod 0755 ${HOME}/bin/pip

# Install Ansible.

ssh-keygen -f ${HOME}/.ssh/id_rsa -t rsa -N ''
cp -v ${HOME}/.ssh/id_rsa.pub ${HOME}/.ssh/authorized_keys

mkdir -pv ${HOME}/bin

cat << EOF > ${HOME}/bin/ansible-playbook-docker
docker run -v ${HOME}/.ssh:/root/.ssh -v $(pwd):/ansible/playbooks tomdymond/ansible:testing2 \$@
EOF

chmod 0755 ${HOME}/bin/ansible-playbook-docker

echo "Run ansible"

${HOME}/bin/ansible-playbook-docker -i ansible/hosts ansible/main.yml

