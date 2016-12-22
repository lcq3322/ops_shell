#!/bin/sh
#source /etc/profile
logdate=`date -d "1 day ago" +%Y-%m-%d`
Log_files=(`find /data/logs/nginx  -name "*log"`)
for logfile in ${Log_files[@]}
do
        mv $logfile ${logfile}-${logdate}
        echo  ${logfile}-${logdate}
#        bzip2 -9 ${logfile}-${logdate}
done
#/usr/sbin/nginx  -s  reload
#find /data/logs/nginx -type f -mtime +60 |grep -E '\.bz2$'|xargs rm -f


