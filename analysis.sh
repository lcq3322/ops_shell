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
 
 
 
 #!/bin/bash
cd /root/
wget 10.10.161.60:17826/files/zabbix-release-2.2-1.el7.noarch.rpm
cd /root/
rpm -ivh zabbix-release-2.2-1.el7.noarch.rpm
yum install -y  zabbix.x86_64  zabbix-agent.x86_64
sleep 3
sed -i 's/Server=127.0.0.1/Server=10.10.76.133/g' /etc/zabbix/zabbix_agentd.conf 
sed -i 's/ServerActive=127.0.0.1/ServerActive=10.10.76.133/g' /etc/zabbix/zabbix_agentd.conf 
systemctl start  zabbix-agent.service
systemctl enable  zabbix-agent.service

 #!/bin/bash

#olddata:990147789

#newdata:990148308


#if [ $# != 1 ] ; then
#    echo "1|parameters error! Usage: $0  funcc" 
#    exit 1;
#fi

#ddd=`mysql -umonitor -pmonitor@allen -h127.0.0.1 -P3306 -s -e "select VARIABLE_VALUE from INFORMATION_SCHEMA.GLOBAL_STATUS where VARIABLE_NAME='COM_SELECT';" | tail -1`
#ooo=`cat /data/scripts/mtj.sh | grep "^#newdata" | awk -F ":"  '{print $2}'`
#sed -i   "3s/#olddata:.*/#olddata:$ooo/"      /data/scripts/mtj.sh
#sed -i   "5s/#newdata:.*/#newdata:$ddd/"      /data/scripts/mtj.sh
#function comselect3306    {
#             echo $ddd-$ooo | bc
#                      }
#$1
 
 
 
