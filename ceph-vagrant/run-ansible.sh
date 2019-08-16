sudo -s

yum install -y python-pip

pip install --upgrade pip
pip install --upgrade setuptools
pip install notario
pip install ansible==2.6.18

wget https://github.com/ceph/ceph-ansible/archive/v3.2.23.tar.gz
tar -zxvf v3.2.23.tar.gz
cd ceph-ansible-3.2.23

cat <<EOF > hosts
[mons]
100.64.0.11 ansible_ssh_user=vagrant
100.64.0.12 ansible_ssh_user=vagrant
100.64.0.13 ansible_ssh_user=vagrant

[osds]
100.64.0.11 ansible_ssh_user=vagrant
100.64.0.12 ansible_ssh_user=vagrant
100.64.0.13 ansible_ssh_user=vagrant

[grafana-server]
100.64.0.11 ansible_ssh_user=vagrant
EOF

cat <<EOF > group_vars/all.yml
cluster: ceph
ceph_origin: distro
ceph_repository: local
ceph_stable_release: luminous
public_network: "100.64.0.0/24"
cluster_network: "100.64.0.0/24"
mon_host: 100.64.0.11,100.64.0.12,100.64.0.13
monitor_interface: eth1
devices:
  - '/dev/sdb'
osd_scenario: collocated
EOF

mv site.yml.sample site.yml

ansible-playbook site.yml -i hosts
