#!/bin/bash

#dubbo上线脚本
#changeLog
#2016.11.24 创建 by lichaoqun
#2016.12.01 更新 by lichaoqun

#参数: $1=项目名
#项目名包括 ser,buss,base,uc
#返回值：通过echo 字符串形式返回
#格式： retcode|retmsg
#example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

###maybe use maven###

ddd=`date "+%Y%m%d-%H%M"`

dirwork="/data/dubbo"

dirpag="/data/api"

dirback="/data/scripts/backup"

#echo ${dirback}
#echo ${dirpag}
#echo ${dirwork}


if [ $# != 1 ] ; then
    echo "1|参数错误! Usage: $0  项目名{ ser | buss | base | uc | synb | syns | misc } "
    exit 1;
fi



if [ $1 == ser ]; then
ps  aux | grep fd-font-api-service | grep -v grep | awk '{print $2}' | xargs kill -9  && echo "停止服务！"
mv  ${dirwork}/fd-font-api-service   ${dirback}/fd-font-api-service-${ddd}        &&  echo "备份完成！"
cp  ${dirpag}/fd-font-api-service-bin.zip  ${dirwork}/                           &&   echo "文件完成拷贝！"
cd  ${dirwork}
/usr/bin/unzip   fd-font-api-service-bin.zip  >> /dev/null      2>&1 &       
sleep 5
#sed -i "s/zk.address=.*/zk.address=zk0:2180,zk1:2181,zk2:2182/g"  ${dirwork}/fd-font-api-service/configs/config-toolkit.properties   && echo "zookerpeer改动完成！"
nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-api-service/fd-font-api-service.jar  >> /data/logs/dubbo/service.log 2>&1  &  

fi



