#!/bin/bash

#赋予用户ttyc权限，实现免密码切换到ttyc。
#changeLog
# 2015.12.12 创建 by lichaoqun

#参数: $1=用户名  
#返回值：通过echo 字符串形式返回
# 格式： retcode|retmsg
# example: 按照最后一个echo的值做判断，如上 0|success, 则程序接口任务的返回值为0

# 需要一个参数
uname=$1

if [ $# != 1 ] ; then 
    echo "1|parameters error! Usage: $0  username " 
    exit 1; 
fi 

uuu=`cat /etc/passwd | grep $uname`
kkk=`su - $uname -c "cd ~;pwd"`

if [ ! $uuu ]; then
	echo "1|user not exist"
    exit 1; 
elif [ ! -f "$kkk"/.ssh/id_rsa.pub ]; then
   tail -12  $0  >  /tmp/cr.sh   
   su - $uname  -c "sh /tmp/cr.sh"  
   mkdir -p /home/ttyc/.ssh  && chown -R ttyc.ttyc  /home/ttyc/.ssh  
rkey=`su - $uname -c "cat ~/.ssh/id_rsa.pub"`
   echo "alias ttyc='ssh ttyc@127.0.0.1'" >> $kkk/.bashrc
   echo "$rkey"  >> /home/ttyc/.ssh/authorized_keys  && echo "0|jobs done!"
else
   echo "file exist!"
   mkdir -p /home/ttyc/.ssh  && chown -R ttyc.ttyc  /home/ttyc/.ssh
rkey=`su - $uname -c "cat ~/.ssh/id_rsa.pub"`
   echo "alias ttyc='ssh ttyc@127.0.0.1'" >> $kkk/.bashrc
   echo "$rkey"  >> /home/ttyc/.ssh/authorized_keys  && echo "0|jobs done!"
fi
exit 




#下面的不要删除！！！



#!/bin/bash
/usr/bin/expect << EOF
spawn ssh-keygen -t rsa
expect "Enter"
send "\n"
expect "Enter passphrase"
send "\n"
expect "Enter same passphrase again"
send "\n"
expect EOF
EOF
