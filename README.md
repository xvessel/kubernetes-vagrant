
首先请自行安装vagrant   

这里描述使用vagrant启动虚拟机，以及在上面搭建k8s的过程。

这里创建的虚拟机大小为2核4G每个，总共三个；因此要求宿主机内存至少16G

这里解决了:  
- 一些镜像需要翻墙的问题  
- ansible自动安装kubernetes  
- vagrant启动的虚机，需要对kubernetes做一些配置  


安装过程：   

```
# 启动虚机  
vagrant up --provision

# ansible安装  
vagrant ssh dev1
cd /vagrant
sudo -s
./ansible-run.sh
```

