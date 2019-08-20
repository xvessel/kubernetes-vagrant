#!/bin/bash
set -e

yum install -y python-pip
pip install --upgrade pip
pip install --upgrade setuptools
pip install notario
pip install ansible==2.6.18
yum install -y sshpass

cat <<EOF > /etc/ansible/ansible.cfg
[defaults]
host_key_checking = False
EOF

ansible-playbook ansible-k8s.yml -i ansible-hosts
