#!/bin/bash

#更改shadow值，达到更改密码的目的。
#changeLog
# 2015.12.09 创建 by lichaoqun

#参数: $1=用户名  $2=密码key值
#注key值有特殊符号应用''括起来,例如  '$6$EUJjcChY$.QyRJj9KiP1ZoS9/OSN/bek92/'
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

# 需要两个参数
if [ $# != 2 ] ; then 
    echo "1|参数错误! Usage: $0 num1 num2" 
    exit 1; 
fi 

uname=$1
ukey=$2

uuu=`cat /etc/shadow | grep $uname` 


if [ ! $uuu ]; then
   echo "1|用户不存在!"  &&  exit 1; 
else
   sed -i "s%${uname}:!!%${uname}:${ukey}%g"  /etc/shadow  &&  echo "0|更改成功!"       
   exit 0;  
fi

