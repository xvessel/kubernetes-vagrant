
首先请自行安装vagrant   

这里描述使用vagrant启动虚拟机，以及在上面搭建k8s的过程。

这里创建的虚拟机大小为2核4G每个，总共三个；因此要求宿主机内存至少16G

这里解决了:  
- 一些镜像需要翻墙的问题  
- ansible自动安装kubernetes  
- vagrant启动的虚机，需要对kubernetes做一些配置  

部署说明：
- dev1, 100.64.11.11, k8s, master
- dev2, 100.64.11.12, k8s, node
- dev3, 100.64.11.13, k8s, node
- dev4, 100.64.11.14, ceph, mon&osd
- dev5, 100.64.11.15, ceph, mon&osd
- dev6, 100.64.11.16, ceph, mon&osd


安装过程：   

```
#编辑vagrant-up.sh中的ip,防止与其他虚机ip冲突 
vim vagrant-up.sh 
# 启动虚机  
./vagrant-up.sh

#  登录 
vagrant ssh dev1
cd /vagrant
sudo -s

# 安装k8s 
./ansible-run.sh

# 安装 ceph
./ceph-install.sh

# storage class for rbd 
./storage-class.sh
```

