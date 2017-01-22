#!/bin/bash
yum install -y inxi
yum install -y memtester
yum install -y mailx
touch /tmp/hard.txt 


echo 'set from=ops@ttyongche.com smtp=smtp.ttyongche.com'     >> /etc/mail.rc 
echo 'set smtp-auth-user=ops@ttyongche.com smtp-auth-password=wzy789789'  >> /etc/mail.rc
echo 'set smtp-auth=login' >> /etc/mail.rc


echo -e "系统及内核版本 \n==========================================================================" >> /tmp/hard.txt
cat /etc/issue | head -1  >> /tmp/hard.txt
uname -r >> /tmp/hard.txt

echo -e "硬件概要 \n=========================================================================="  >> /tmp/hard.txt
inxi -c 5 -b  >> /tmp/hard.txt

echo -e "详细概要 \n==========================================================================" >> /tmp/hard.txt
inxi -F >> /tmp/hard.txt

echo -e "CPU信息 \n==========================================================================" >> /tmp/hard.txt
lscpu >> /tmp/hard.txt

echo -e "MEM信息 \n==========================================================================" >> /tmp/hard.txt
cat /proc/meminfo >> /tmp/hard.txt

echo -e "磁盘信息 \n==========================================================================" >> /tmp/hard.txt
lsblk >> /tmp/hard.txt

echo -e "磁盘分区信息 \n==========================================================================" >> /tmp/hard.txt
fdisk -l >> /tmp/hard.txt

echo -e "BIOS信息 \n==========================================================================" >> /tmp/hard.txt
dmidecode -t bios >> /tmp/hard.txt

hname=`hostname`

cat  /tmp/hard.txt  | mail -s $hname  op.list@ttyongche.com  





#set from=fdzabbixwar@163.com
#set smtp=smtp.163.com
#set smtp-auth-user=fdzabbixwar@163.com
#set smtp-auth-password=zty2016
##set smtp-auth-password=zty2016%
#set smtp-auth=login




