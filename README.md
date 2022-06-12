# synology-baiduNetdisk-package

百度云的群晖套件，基于百度云Linux版客户端

#### 请注意务必升级群晖至DSM6.2.x以上的版本，以下版本的DSM由于Linux内核为v3版本，无法运行最新版本的百度云linux客户端。[官方更新日志](https://www.synology.com/zh-cn/security/advisory/Synology_SA_19_28)

## 安装

在releases页面下载spk安装包，然后在DSM套件中心中手动安装。注意，spk不包含签名，请在套件中心中设置信任“任何发行者”，避免安装被阻止。

## DSM7

目前无法支持DSM7，代码已更新到DSM7分支，但问题在于群晖几乎没有任何沟通渠道，错误无法调试，也没有任何错误相关的技术资料，导致安装包还无法正常运行。

## 自行编译

./pkgCreate.sh 即可在build目录生成spk安装包。

## 问题（2020-09-15更新）

1. 客户端停留在加载界面的进度条中，一直无法进入主界面，也不出现登录界面，怎么办？

   在BDdownload文件夹下创建一个.reset文件夹。然后，重启johnshine/baidunetdisk-crossover-vnc:latest对应的docker容器即可。

   这个应该是客户端本身的登录问题，清除后，需要重新登录客户端。

2. 如何设置vnc的连接密码？

   首先在本地创建passwd.txt文本文件，内容写上vnc的连接密码。然后在BDdownload文件夹下创建一个.vnc文件夹，将passwd.txt文件上传到.vnc文件夹下面。最后重启对应的docker容器即可。

3. 如何更新百度云客户端为最新版?

   由于最新版客户端兼容性很有问题，在目前群晖至少DSM6.0上无法运行，因此群晖环境下，不建议升级到最新版。

4. 镜像在国外pull速度慢怎么办?

   在下面的网盘下载镜像打包后的文件（网盘分享可能会失效），上传到nas中，然后在ssh的终端下运行下面的命令（注意修改为实际的文件路径）：
   ```docker load < baidunetdisk-crossover-vnc\:latest.tar```
   
   https://590m.com/f/31142793-480894558-bb2be5 （访问密码：1201）
   
5. 进入novnc界面全屏灰色，没有出现百度网盘客户端界面是怎么回事？

   这样说明网盘客户端无法启动，就需要查看以下内核的版本。输入uname -r, 必须是4.0以上的内核才支持最新版本的客户端。
   目前发现DS3615xs的DSM 6.2.3-25426 Update 3的内核版本为3.10.105，无法支持最新版本的镜像，只能使用3.x及以下版本的镜像: 
   
   ```docker pull johnshine/baidunetdisk-crossover-vnc:3.1```
   
   ```docker tag johnshine/baidunetdisk-crossover-vnc:3.1 johnshine/baidunetdisk-crossover-vnc:latest。```
   
   然后Docker套件内删除原有的docker容器，并重启该群晖套件即可。
