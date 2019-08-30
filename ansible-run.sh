#!/bin/bash
set -e

#yum install -y python-pip
#pip install --upgrade pip
#pip install --upgrade setuptools
#pip install notario
#pip install ansible==2.6.18
#yum install -y sshpass

if [[ ! -d /etc/ansible ]]; then 
	mkdir /etc/ansible
fi

mkdir /etc/ansible
cat <<EOF > /etc/ansible/ansible.cfg
[defaults]
host_key_checking = False
EOF

ansible-playbook ansible-k8s.yml -i ansible-hosts

#命令行自动补全
source <(kubectl completion bash)


