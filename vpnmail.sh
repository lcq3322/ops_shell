#!/bin/bash

#开通vpn,邮件通知.    (只可以在 OfficVpn.ttyc 运行.)
#changelog
# 2015.12.11 创建 by lichaoqun

#参数: $1=用户名 
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

# 需要一个参数用户名
if [ $# != 1 ] ; then 
  echo "1|参数错误! Usage: $0 username " 
  exit 1; 
fi 
#iip=`ip add | grep 'inet 172.16.10.222'`

#if [ ! $iip ] ; then
#   echo "1|环境错误! 请在OfficVpn.ttyc运行" 
#   exit 1;
#fi   
#yum install -y expect
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin:/usr/bin:/bin:/usr/local/bin"
export LANG LC_ALL PATH

uuu=$1
if [ ! $uuu ];then
     echo '1|Please Use "sh vpnmail.sh username"'
else
test -e /etc/openvpn/easy-rsa/keys/$uuu.crt
  if [ $? -eq 0 ]; then
echo "file  exist !!!"
rm -rf /data/scripts/files/$uuu
mkdir -p /data/scripts/files/$uuu
cp /etc/openvpn/easy-rsa/keys/ca.crt   /data/scripts/files/$uuu
cp /etc/openvpn/easy-rsa/keys/$uuu.crt /data/scripts/files/$uuu
cp /etc/openvpn/easy-rsa/keys/$uuu.key /data/scripts/files/$uuu
sleep 1
cp /data/scripts/files/ddd.ovpn    /data/scripts/files/$uuu/ttofficevpn.ovpn
sed -i "s/ddd.crt/$uuu.crt/g"  /data/scripts/files/$uuu/ttofficevpn.ovpn
sed -i "s/ddd.key/$uuu.key/g"  /data/scripts/files/$uuu/ttofficevpn.ovpn
sleep 1
cd /data/scripts/files/
tar zcf  ttofficevpn.tar.gz  $uuu  && mv ttofficevpn.tar.gz  $uuu
sleep 2
mail -a /data/scripts/files/$uuu/ttofficevpn.tar.gz -s VPN权限开通 $uuu@ttyongche.com < /data/scripts/files/content.txt  && echo "0|jobs done!!!"
  else
cd /etc/openvpn/easy-rsa && source ./vars
#source vars
/usr/bin/expect << EOF
spawn sh build-key $uuu 
expect "Country Name"
send "\n"
expect "State or Province Name"
send "\n"
expect "Locality Name"
send "\n"
expect "Organization Name"
send "\n"
expect "Organizational Unit Name"
send "\n"
expect "Common Name"
send "\n"
expect "Name"
send "\n"
expect "Email Address"
send "\n"
expect "A challenge password"
send "\n"
expect "An optional company name"
send "\n"
expect "Certificate is to be certified until"
send "y\n"
expect "1 out of 1 certificate requests certified, commit?"
send "y\n"
expect EOF
EOF
rm -rf /data/scripts/files/$uuu
mkdir -p /data/scripts/files/$uuu
cp /etc/openvpn/easy-rsa/keys/ca.crt   /data/scripts/files/$uuu
cp /etc/openvpn/easy-rsa/keys/$uuu.crt /data/scripts/files/$uuu
cp /etc/openvpn/easy-rsa/keys/$uuu.key /data/scripts/files/$uuu
sleep 1
cp /data/scripts/files/ddd.ovpn    /data/scripts/files/$uuu/ttofficevpn.ovpn    
sed -i "s/ddd.crt/$uuu.crt/g"  /data/scripts/files/$uuu/ttofficevpn.ovpn
sed -i "s/ddd.key/$uuu.key/g"  /data/scripts/files/$uuu/ttofficevpn.ovpn
sleep 1
cd /data/scripts/files/
tar zcf  ttofficevpn.tar.gz  $uuu  && mv ttofficevpn.tar.gz  $uuu
sleep 2
mail -a /data/scripts/files/$uuu/ttofficevpn.tar.gz -s VPN权限开通 $uuu@ttyongche.com < /data/scripts/files/content.txt  && echo "0|jobs done!!!"
  fi
fi


#1. 安装openvpn图形界面和openvpn程序
#   根据操作系统版本，下载其中之一的安装文件(来自https://openvpn.net/index.php/open-source/downloads.html)并安装:
#   32位操作系统 http://openvpn.ustc.edu.cn/openvpn-install-2.3.6-I003-i686.exe
#   64位操作系统 http://openvpn.ustc.edu.cn/openvpn-install-2.3.6-I003-x86_64.exe
#   安装TAP驱动的时候有个没有经过数字签名的警告,选择允许安装。
   
#2. 把邮件附件中的openvpn配置文件ttofficevpn.tar.gz下载到机器临时目录，并解压出4个文件，将这4个文件拷贝到到openvpn安装目录config下面,一般是
#   C:\program files\openvpn\config，也可能是C:\Program Files (x86)\OpenVPN\config

#3. 到openvpn的安装目录bin下(默认是C:\program files\openvpn\bin)，找到openvpn-gui.exe, 在这个openvpn-gui.exe文件上单击鼠标右键,选择"以管理员身份运行"(英语是Run as Administrator)
