# Livy Chart构建
## 一、编译打包livy
执行 package_livy.sh，生成livy zip包

## 二、build livy-spark 镜像
1. 将 apache-livy-0.7.0-incubating-bin.zip 拷贝到 livy-spark 目录下
2. 确认 Dockerfile 中的spark镜像是正确的
3. 构建 livy-spark 镜像

在157上执行： aws ecr get-login --no-include-email --region us-east-1
docker build --network=host -t 818539432014.dkr.ecr.us-east-1.amazonaws.com/engineplus/spark-dev:livy-spark-v10 -f ./Dockerfile .
docker push 818539432014.dkr.ecr.us-east-1.amazonaws.com/engineplus/spark-dev:livy-spark-v10

## 三、build livy-server 镜像
1. 修改 livy-server 路径中 Dockerfile 的 SPARK_BASE 为最新的 livy-spark 镜像
2. 构建 livy-server 镜像

docker build --network=host -t 818539432014.dkr.ecr.us-east-1.amazonaws.com/engineplus/spark-dev:livy-server-v12 -f ./Dockerfile .
docker push 818539432014.dkr.ecr.us-east-1.amazonaws.com/engineplus/spark-dev:livy-server-v12

## 四、构建 helm chart
1. 修改 helm-chart 路径中 values.yaml 参数 image.repository 和 image.tag 为最新的 livy-server 镜像
2. 修改 values.yaml 参数 env.LIVY_SPARK_KUBERNETES_CONTAINER_IMAGE 为最新的 livy-spark 镜像
3. 如果 livy 的 rsc-jars 有变动，更新 values.yaml 参数 LIVY_LIVY_RSC_JARS
4. 执行 helm lint --strict livy/ 校验helm chart是否正确
5. 执行 helm package livy 打包 livy chart
6. 若已存在旧版本livy，先卸载
7. 执行 helm install livy-server livy-0.1.0.tgz --namespace livy --set rbac.create=true 安装 livy-server

卸载helm release：
helm ls -n livy
helm uninstall livy-server -n livy


进入命令行操作：
kubectl exec -it --namespace livy livy-server-0 -- /bin/sh
安装ps命令
apt-get install -y procps
安装python环境（这一步可以提前打到环境中）
apt-get install -y python
apt-get install -y python-pip
pip install requests


kubectl auth can-i list pods --as=system:serviceaccount:livy:livy-server-spark -n livy


安装网络工具
apt-get install net-tools
netstat  -anp


