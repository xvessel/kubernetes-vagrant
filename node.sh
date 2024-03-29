#! /bin/bash
set -e
chmod +x /usr/bin/docker-pull

docker-pull quay.io/coreos/flannel:v0.11.0-amd64
docker-pull k8s.gcr.io/coredns:1.3.1
docker-pull k8s.gcr.io/etcd:3.3.10
docker-pull k8s.gcr.io/pause:3.1
docker-pull k8s.gcr.io/kube-proxy:v1.15.0


nodeip=`ip addr show dev eth1  | grep "100\.64\.[0-9]*\.[0-9]*" -o | head -1`
# https://kubernetes.io/zh/docs/reference/setup-tools/kubeadm/kubeadm-init/

sed -i "s/KUBELET_EXTRA_ARGS *$/KUBELET_EXTRA_ARGS --node-ip=${nodeip}/g" /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf

#kubeadm join 100.64.11.11:6443 --token n8hou8.5kwui9pea8ecky0z \
#    --discovery-token-ca-cert-hash sha256:9d3353eb01827cae6e0e5227fbfb3b40b00c9adca41ab58f07e8e3f257859613
#    --node-ip=

