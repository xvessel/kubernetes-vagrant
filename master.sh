#! /bin/bash
set -e
./docker-pull k8s.gcr.io/kube-proxy:v1.15.0
./docker-pull k8s.gcr.io/kube-apiserver:v1.15.0
./docker-pull k8s.gcr.io/kube-controller-manager:v1.15.0
./docker-pull k8s.gcr.io/kube-scheduler:v1.15.0
./docker-pull quay.io/coreos/flannel:v0.11.0-amd64
./docker-pull k8s.gcr.io/coredns:1.3.1
./docker-pull k8s.gcr.io/etcd:3.3.10
./docker-pull k8s.gcr.io/pause:3.1

kubeadm  init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=100.64.0.11

################
#To start using your cluster, you need to run the following as a regular user:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


## flannel
#wget https://raw.githubusercontent.com/coreos/flannel/62e44c867a2846fefb68bd5f178daf4da3095ccb/Documentation/kube-flannel.yml
#kube-flannel.yml 加入参数 '--iface=eth1'
#        args:
#        - --ip-masq
#        - --kube-subnet-mgr
#        - --iface=eth1
kubectl apply -f  kube-flannel.yml

#You should now deploy a pod network to the cluster.
#Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
#  https://kubernetes.io/docs/concepts/cluster-administration/addons/
#
#Then you can join any number of worker nodes by running the following on each as root:

#kubeadm join 10.0.2.15:6443 --token nmtov9.e7m6z3qkwko6g0ak \
#    --discovery-token-ca-cert-hash sha256:7974e887b58f25e3667cd5c74586612adc8e81b0c05e43729450e2e4dbe1e931
