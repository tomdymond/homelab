#!/bin/bash -eux

${HOME}/bin/ansible-playbook-docker -i ansible/hosts ansible/main.yml

