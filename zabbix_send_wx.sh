#!/bin/bash

CropID='yourID'
Secret='yourSEC'
GURL="https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=$CropID&amp;corpsecret=$Secret"

Gtoken=`curl -s -G "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=yourID&corpsecret=yourSEC" | awk -F\" '{print $4}'`

#Gtoken=$(/usr/bin/curl -s -G $GURL | awk -F\" '{print $4}')

 
#echo  $Gtoken

PURL="https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=$Gtoken"
 
function body() {
        local int AppID=1
        local UserID=${1}
        local PartyID=1
        local Msg=$(echo "$@" | cut -d" " -f3-)
        printf '{\n'
        printf '\t"touser":"'"@all"\"",\n"
        printf '\t"toparty":"'"$PartyID"\"",\n"
        printf '\t"msgtype":"text",\n'
        printf '\t"agentid":'"$AppID"",\n"
        printf '\t"text": {\n'
        printf '\t\t"content": "'"$Msg"\""\n"
        printf '\t},\n'
        printf '\t"safe":0\n'
        printf '}\n'
}

#echo $Msg

#echo $(body)

/usr/bin/curl --data-ascii "$(body $1 $2 $3)" $PURL
