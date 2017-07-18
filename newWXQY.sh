[root@ops scripts ]$ cat o.sh 
#!/bin/bash

#报警信息:  AgentId  1


ddd="测试test"
SMES=''${ddd}'045{[<53-_~;te>st你的快递已到'


CropID='yourid'
Secret='yourser'
GURL="https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=$CropID&corpsecret=$Secret"

if [ "$1"x == "reset"x ] ; then
rm -rf /tmp/keyfile && echo "delete file!!!"
Gtoken=`curl -s -G  $GURL | awk -F\" '{print $10}'`
echo $Gtoken  > /tmp/keyfile  && echo 'cached!!!'
exit
fi

kfile=`find /tmp/  -name keyfile  -type f -mmin +118`

if [ ! $kfile ]; then 
Gtoken=`cat /tmp/keyfile` 
else
Gtoken=`curl -s -G  $GURL | awk -F\" '{print $10}'`
echo $Gtoken  > /tmp/keyfile  && echo 'NEW TOKEN CACHED!!!'
fi

PURL="https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=$Gtoken"



/usr/bin/curl --data-ascii '{"touser" : "@all","msgtype" : "text","agentid" : 1,"text" : {"content" : '\"$SMES\"'},"safe":0}' $PURL

