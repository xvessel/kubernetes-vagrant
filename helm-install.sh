wget https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz
tar -zxvf helm-v2.14.3-linux-amd64.tar.gz 
cp ./linux-amd64/helm /usr/bin

helm init --upgrade -i registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:v2.5.1 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
#nohup ./linux-amd64/tiller > ./linux-amd64/tiller.out &
#export HELM_HOST=localhost:44134
