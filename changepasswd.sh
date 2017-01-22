#!/bin/bash

#直接更改密码
#changeLog
# 2015.12.09 创建 by lichaoqun

#参数: $1=用户名  $2=密码
#密码包含特殊字符应用''括起来,例如  'nbok666％.$'
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

# 需要两个参数
if [ $# != 2 ] ; then 
    echo "1|参数错误! Usage: $0 num1 num2" 
    exit 1; 
fi 

uname=$1
upass=$2

uuu=`cat /etc/passwd | grep $uname` 
exp=`rpm -qa expect`   

if [ ! $uuu ]; then
   echo "1|用户不存在!"  &&  exit 1; 
elif [ ! $exp ]; then
   yum install -y expect
   /usr/bin/expect << EOF
spawn passwd $uname
expect "New password"
send "$upass\n"
expect "Retype new password"
send "$upass\n"
expect EOF
EOF
   echo  "0|修改成功!"
else
   /usr/bin/expect << EOF
spawn passwd $uname
expect "New password"
send "$upass\n"
expect "Retype new password"
send "$upass\n"
expect EOF
EOF
   echo  "0|修改成功!" 
fi
