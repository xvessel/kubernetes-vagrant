
这里描述使用vagrant启动虚拟机，以及在上面搭建k8s的过程。

这里创建的虚拟机大小为2核4G每个，总共三个；因此要求宿主机内存至少16G

docker-pull内部做了选择不同mirror拉取镜像。  

- 启动虚机  
```
vagrant up
```

- master安装  
```
vagrant ssh dev1
cd /vagrant
./prepare.sh
./master.sh  #拉镜像可能会失败，多执行几次
#输出内容kubeadmi join...要在node上执行
```

- node安装  
```
vagrant ssh dev2
cd /vagrant
./prepare.sh
./node.sh  #拉镜像可能会失败，多执行几次
vim /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS --node-ip=100.64.0.13

#执行master输出的内容
```

- check
```
kubectl get pod -A
```

- run a deployment
```
kubectl apply -f nginx-deployment.yml
```

- delete a node
```
# on master
kubectl delete node dev2
# on node
./reset.sh
```
