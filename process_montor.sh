#!/bin/bash

#进程监控
#changelog
# 2015.10.12 创建 by lichaoqun
# 2015.12.26 修改 by lichaoqun

#参数: 无
#返回值：通过邮件形式返回
# 格式： $mjp进程不存在




export mts="xxx@xxx.com xxx@139.com"

export mjp="tomcat_xxx nginx_xxx"



for i in $mjp
do
ttt=`ps aux | grep ${i} |  grep -v grep | awk '{print $2}'`
  if [ ! $ttt ];then
    for m in $mts
    do
      echo  "${i}进程不存在" |  mail -s  prosswarn  ${m}
    done   
  else
    exit 0
  fi
done




exit 0
