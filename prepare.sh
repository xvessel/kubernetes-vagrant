#!/bin/bash
set -e

wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

yum install -y docker

cat <<EOF > /etc/docker/daemon.json
{
"registry-mirrors":["http://hub-mirror.c.163.com"]
}
EOF

systemctl start docker
systemctl enable docker

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
        http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

yum install -y kubelet-1.15.0 kubeadm-1.15.0 kubectl-1.15.0 --disableexcludes=kubernetes

systemctl enable --now kubelet

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

sysctl net.bridge.bridge-nf-call-iptables=1
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

systemctl stop firewalld
systemctl disable firewalld
