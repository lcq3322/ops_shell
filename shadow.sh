#!/bin/bash
uuu=$1
mmm=$2
upwd=`pwd`
touch  ${upwd}/authorization.table
pdb=${upwd}/authorization.table
#echo $upwd
if  [ ! $uuu ]; then
  echo 'Please Use "sh shadow.sh 用户名 机器名"'
else  
upass=`cat $upwd/shadow.sh| grep $uuu | awk -F ":" '{print $2}' `
  if [ ! $upass  ];then
  npass=`cat /dev/urandom | head -n 10 | md5sum | head -c 14`
  useradd  $uuu 
/usr/bin/expect << EOF
spawn passwd $uuu 
expect "New password"
send "$npass\n"
expect "Retype new password"
send "$npass\n"
expect EOF
EOF
echo "您的服务器密码是 $npass  请妥善保管." | mail -s 线上服务器权限开通 $uuu@ttyongche.com
nppp=`cat /etc/shadow | grep $uuu | awk -F ":" '{print $2}'`
echo "#$uuu:$nppp" >>  $upwd/shadow.sh
#echo "#$uuu:$nppp"  
#echo  $upass
  userdel $uuu
    if [ ! $mmm  ];then
       echo '"请输入需要添加用户的机器"' 
    else
       echo "$uuu   $mmm" >> $pdb
           salt  -E "$mmm"  cmd.run "useradd $uuu"
#          salt  -E "$mmm"  cmd.run "/bin/sed -i "s%${uuu}:!!%${uuu}:'`echo $nppp%`'g" /etc/shadow "
           salt  -E "$mmm"  cmd.run "/bin/sed -i "s%${uuu}:!!%${uuu}:\'${nppp}\'%g" /etc/shadow "
           echo -e "您的线上服务器权限已经开通.\n(此邮件自动发送)" | mail -s 线上服务器权限开通 $uuu@ttyongche.com
    fi 
  else
    if [ ! $mmm  ];then
                echo '"请输入需要添加用户的机器"'
    else
       echo "$uuu   $mmm" >> $pdb  
       salt  -E "$mmm"  cmd.run "useradd $uuu"
#       salt  -E "$mmm"  cmd.run "/bin/sed -i "s%${uuu}:!!%${uuu}:'`echo $upass`'%g" /etc/shadow"
       salt  -E "$mmm"  cmd.run "/bin/sed -i "s%${uuu}:!!%${uuu}:\'${upass}\'%g" /etc/shadow"
       echo -e "您的线上服务器权限已经开通.\n(此邮件自动发送)" | mail -s 线上服务器权限开通 $uuu@ttyongche.com 
    fi
  fi
fi
exit

#####-------------------------------passdb-----------------------------#####

#zhaomingqiang:$6$oI.SQ5My$8y6jLy5ikyFOb/60MF.1axkcDlTqCaojQb9gqkbUfjC2RkQ3OLXIGMdqNCIgptjmZrXXRTaFo5kt2X7CXGDYh0
