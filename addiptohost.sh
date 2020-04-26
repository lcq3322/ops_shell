#!/bin/bash
DockerLIST=`docker ps -a | grep 'Up'|  grep  'jar' |  awk '{print $1}'`
for i in  ${DockerLIST}
do
DockerIP=`docker inspect ${i} | grep '"IPAddress"' | tail -1 | awk -F '"'  '{print $4}' `
CheckIp=`cat /root/tmp  | grep "${i}"`
if [ -z "${CheckIp}" ]; then
echo  ${DockerIP}  ${i} >> /root/tmp
fi
done
exit
