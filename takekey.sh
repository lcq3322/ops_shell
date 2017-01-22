#!/bin/bash

#生成shadow所需的key值
#changeLog
# 2015.12.11 创建 by lichaoqun

#参数: $1=密码
#密码包含特殊字符应用''括起来,例如  'nbok666％.$'
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

# 需要两个参数
if [ $# != 1 ] ; then 
    echo "1|参数错误! Usage: $0  密码 " 
    exit 1; 
fi 

tuuu=t`date +%Y%m%d`
upass=$1
exp=`rpm -qa expect`   

if [ ! $exp ]; then
    yum install -y expect   ||  exit 1;	
    useradd $tuuu   ||  exit 1;
/usr/bin/expect << EOF
spawn passwd $tuuu
expect "New password"
send "$upass\n"
expect "Retype new password"
send "$upass\n"
expect EOF
EOF
ukey=`cat /etc/shadow | grep $tuuu | awk -F ":" '{print $2}'`
echo "0|{$ukey}"   && userdel  $tuuu
else   
    useradd $tuuu   ||  exit 1;
/usr/bin/expect << EOF
spawn passwd $tuuu
expect "New password"
send "$upass\n"
expect "Retype new password"
send "$upass\n"
expect EOF
EOF
ukey=`cat /etc/shadow | grep $tuuu | awk -F ":" '{print $2}'`
echo "0|${ukey}"   && userdel  $tuuu
fi

