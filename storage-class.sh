
cat <<EOF > hosts
[ceph]
100.64.11.14 ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
EOF
key64=`ansible ceph -b --become-user=root --become-method=sudo -i hosts -m shell -a "ceph osd  pool create kube 64 > /dev/null 2>&1; ceph auth get-key client.admin  | base64" | tail -1 `
rm hosts

sed -i "s/key: .*$/key: ${key64}/" storage-class-secret.yml

##  storage provision
#https://github.com/kubernetes-incubator/external-storage/tree/master/ceph/rbd
wget https://github.com/kubernetes-incubator/external-storage/archive/v5.5.0.tar.gz
tar -zxvf v5.5.0.tar.gz
cd external-storage-5.5.0/
cd ceph/rbd/deploy/rbac/
NAMESPACE=kube-system # change this if you want to deploy it in another namespace
sed -r -i "s/namespace: [^ ]+/namespace: $NAMESPACE/g" ./rbac/clusterrolebinding.yaml ./rbac/rolebinding.yaml
kubectl -n $NAMESPACE apply -f ./rbac

kubectl create -f storage-class-secret.yml    storage-class.yml

# for test
#kubectl create -f storage-class-pvc.yml 
