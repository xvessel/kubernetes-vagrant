#!/bin/bash
set -e

#yum install -y python-pip
#pip install --upgrade pip
#pip install --upgrade setuptools
#pip install notario
#pip install ansible==2.6.18
#yum install -y sshpass

if [[ ! -d "ceph-ansible-3.2.23" ]]; then
wget https://github.com/ceph/ceph-ansible/archive/v3.2.23.tar.gz
tar -zxvf v3.2.23.tar.gz
fi
cd ceph-ansible-3.2.23

cat <<EOF > hosts
[mons]
100.64.11.14 ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
100.64.11.15 ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
100.64.11.16 ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

[osds]
100.64.11.14 ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
100.64.11.15 ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
100.64.11.16 ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

[grafana-server]
100.64.11.14 ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
EOF

cat <<EOF > group_vars/all.yml
cluster: ceph
ceph_origin: distro
ceph_repository: local
ceph_stable_release: luminous
public_network: "100.64.0.0/16"
cluster_network: "100.64.0.0/16"
mon_host: 100.64.11.14,100.64.11.15,100.64.11.16
monitor_interface: eth1
devices:
  - '/dev/sdb'
osd_scenario: collocated
EOF

cp site.yml.sample site.yml

sed -i "s/-o PreferredAuthentications=publickey//" ansible.cfg

ansible mons -b --become-user=root --become-method=sudo -i hosts -m script -a "../ceph-prepare.sh" -vvv

ansible-playbook site.yml -i hosts
