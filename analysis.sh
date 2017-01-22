#!/bin/bash


#监控统计模板
#changeLog
# 2017.01.22 创建 by lcq

#参数: num1 
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0
#用途：分析监控采集信息


function tload {
        #cat /data/scripts/tongji/tjdata.txt | grep '系统负载:' | awk -F ":" '{print $NF}' | awk -F "," '{sum += $1;sum2 += $2;sum3 += $3 ;} END { print sum,sum2,sum3}'
        cat /data/scripts/tongji/tjdata.txt | grep '系统负载:' | awk -F ":" '{print $NF}' | awk -F "," '{sum += $1;sum2 += $2;sum3 += $3 ;} END { print sum2}'
                            }

function aload {
    #cat /data/scripts/tongji/tjdata.txt | grep '系统负载:' | awk -F ":" '{print $NF}' | awk -F "," '{sum += $1;sum2 += $2;sum3 += $3 ;} END { print sum/NR,sum2/NR,sum3/NR}'
    cat /data/scripts/tongji/tjdata.txt | grep '系统负载:' | awk -F ":" '{print $NF}' | awk -F "," '{sum += $1;sum2 += $2;sum3 += $3 ;} END { print sum2/NR}'
                            }

function tpross {
    cat /data/scripts/tongji/tjdata.txt | grep '系统进程数:'| awk -F ":" '{print $2}' | awk '{ sum += $1; } END { print sum}'
                            }

function apross {
        cat /data/scripts/tongji/tjdata.txt | grep '系统进程数:'| awk -F ":" '{print $2}' | awk '{ sum += $1; } END { printf "%.0f",sum/NR}'
                            }
                            
$1                            
 
 
 
 
 
 
 
 
