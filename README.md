# ddns-cloudXNS
通过CloudXNS的API实现DDNS更新功能，并微信通知。

### 用法
1. 下载DDNS.sh
2. 填写CloudXNS的API Key、Secret Key。
3. 到 http://sc.ftqq.com/ 获得SCKEY并填写，用于微信消息推送。
4. 将需要更新的域名填写到TARGET。
5. 多出口的环境设置INTERFACE值指定网口（单网卡环境留空值即可）

		INTERFACE="--interface ppp0"    #使用拨号时
		INTERFACE="--interface eth0"    #用网卡

5. 给DDNS.sh添加执行权限，运行`DDNS.sh`。

### 路由器设置

##### merlin
在Tools->Script中，添加WAN-START脚本。 
