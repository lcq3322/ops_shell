#!/bin/bash

#添加新用户,更改密码，更改组。
#changeLog
# 2015.12.11 创建 by lichaoqun

#参数: $1=用户名  $2=key值  $3=组
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

# 需要二或三个参数
uname=$1
ukey=$2
ugroup=$3


if [ $# == 2 -o $# == 3 ] ; then 
uuu=`cat /etc/passwd | grep $uname`
    if [ ! $uuu ]; then
         mkdir -p /data/home
         useradd $uname  -d /data/home/$uname &&  echo "0|添加成功!"   
         chown -R ${uname}.${uname} /data/home/$uname
         sed -i "s%${uname}:!!%${uname}:${ukey}%g"  /etc/shadow  &&  echo "0|更改成功!"       
         
         if [ ! $ugroup ]; then
         	exit 0;   
         else
#            usermod -a -G $ugroup $uname &&  echo "0|更改成功!"
			echo "$uname    ALL=(ALL)       ALL"  >> /etc/sudoers
         fi
           
    else
         if [ ! $ugroup ]; then
            echo "0|啥也没做!" 
            exit 0;   
         else
#            usermod -a -G $ugroup $uname &&  echo "0|更改成功!"
            echo "$uname    ALL=(ALL)       ALL"  >> /etc/sudoers			
         fi  

    fi      
else
    echo "1|参数错误! Usage: $0 用户名 key值 所属组" 
    exit 1; 
fi 

