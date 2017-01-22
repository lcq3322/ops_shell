#!/bin/bash
export mmm="13666666666 13888888888"

sss=ab37655347122540857b44950fca0ba3
ddd=`date '+%Y%m%d%H%M%S'`
rrr=`echo $RANDOM` 
signnum="$sss$ddd$rrr"
sign=`/opt/php-5.6.10/bin/php -r "echo sha1("$sss$ddd$rrr$rrr");"`
nlog=/data/logs/nginx/api/access_log
tail -10000 $nlog | grep -v 200 | grep -v baidu  > /tmp/t.log
unum=`cat /tmp/t.log | wc -l`
ufze=`cat /tmp/t.log | grep 502 | wc -l`

if [ $unum -ge 10 ]; then
    content='nginx日志错误较多!!!'
    for i in $mmm; do
        curl -d "from=monlog" -d "mobiles=${i}" -d"content=${content}" -d"timestamp=${ddd}" -d "rand=${rrr}${rrr}" -d "sign=${sign}" -s "http://10.10.135.97:12800/sms/send" 
    done 
fi
