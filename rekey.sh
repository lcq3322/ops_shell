#!/bin/bash

#更改key值，即密码。
#changeLog
# 2015.12.12 创建 by lichaoqun

#参数: $1=用户名  $2=key值 
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

# 需要二个参数
uname=$1
ukey=$2

if [ $# != 2 ] ; then 
    echo "1|parameters error! Usage: $0  username  key" 
    exit 1; 
fi 

uuu=`cat /etc/passwd | grep $uname`

if [ ! $uuu ]; then
    echo "1|user not exist"
else
zzz=`cat /etc/shadow | grep $uname | cut -d : -f  3-10`
    sed -i "s%$uname:.*:%$uname:"$ukey":"$zzz"%g" /etc/shadow   &&   echo  "0|jobs done!"
fi

