#!/bin/bash

#开通vpn,邮件通知.    (只可以在 Openvpn.xxx 运行.)
#changelog
# 2015.12.11 创建 by lichaoqun
# 2019.04.16 更改 by lichaoqun

#参数: $1=用户名 
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

# 需要一个参数用户名
if [ $# != 1 ] ; then 
  echo "1|参数错误! Usage: $0 username,must be mailbox prefix!!!" 
  exit 1; 
fi 
#iip=`ip add | grep 'inet 192.168.242.128'`

#if [ ! $iip ] ; then
#   echo "1|环境错误! 请在OfficVpn.xxx运行" 
#   exit 1;
#fi   
#yum install -y expect
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin:/usr/bin:/bin:/usr/local/bin"
export LANG LC_ALL PATH

uuu=$1

function sendmail () {
rm -rf /data/scripts/files/$uuu
mkdir -p /data/scripts/files/$uuu
cp /etc/openvpn/easy-rsa/pki/ca.crt               /data/scripts/files/$uuu
cp /etc/openvpn/easy-rsa/pki/issued/$uuu.crt      /data/scripts/files/$uuu
cp /etc/openvpn/easy-rsa/pki/private/$uuu.key     /data/scripts/files/$uuu
sleep 1
cp /data/scripts/files/ddd.ovpn    /data/scripts/files/$uuu/xxxvpn.ovpn
sed -i "s/ddd.crt/$uuu.crt/g"  /data/scripts/files/$uuu/xxxvpn.ovpn
sed -i "s/ddd.key/$uuu.key/g"  /data/scripts/files/$uuu/xxxvpn.ovpn
sleep 1
cd /data/scripts/files/
tar zcf  xxxvpn.tar.gz  $uuu  openvpn-install-2.4.7-I601.exe  && mv xxxvpn.tar.gz  $uuu
sleep 2
mail -a /data/scripts/files/$uuu/xxxvpn.tar.gz -s VPN权限开通 $uuu@xxx.cn < /data/scripts/files/content.txt  && echo "0|jobs done!!!"
}

if [ ! $uuu ];then
     echo '1|Please Use 'sh vpnmail.sh username must be mailbox prefix!!!''
else
test -e /etc/openvpn/easy-rsa/pki/issued/$uuu.crt
  if [ $? -eq 0 ]; then
echo "file  exist !!!"
sendmail
  else
#cd /etc/openvpn/easy-rsa && source ./vars
cd /etc/openvpn/easy-rsa 
#source vars
/usr/bin/expect << EOF
#spawn sh build-key $uuu 
spawn ./easyrsa build-client-full $uuu  nopass
expect "/etc/openvpn/easy-rsa/pki/private/ca.key:"
send "PASSWD\n"   ### ca pass
expect EOF
EOF
sendmail
  fi
fi
