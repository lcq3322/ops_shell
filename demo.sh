#!/bin/bash

#brife 脚本工具编写模板
#changeLog
# 2015.12.09 创建 by willas

#参数: num1 num2
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

LANG=C
LC_ALL=C
PATH="$PATH:/sbin:/usr/sbin:/usr/local/sbin:/usr/bin:/bin:/usr/local/bin"
export LANG LC_ALL PATH

# 需要两个参数
if [ $# != 2 ] ; then 
    echo "Usage: $0 num1 num2" 
    exit 1; 
fi 

num1=$1
num2=$2

let "sum=$num1 + $num2"
echo $sum
if [ "$sum" == "1" ]; then
    echo "0|success"
else
    echo "1|fail"
fi
