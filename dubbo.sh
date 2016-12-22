
















nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-api-business/fd-font-api-business.jar  &





nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-api-business/fd-font-api-business.jar >> /data/logs/dubbo/bussiness.log &

nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-api-service/fd-font-api-service.jar  >> /data/logs/dubbo/service.log &

nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-base-service/fd-font-base-service.jar  >> /data/logs/dubbo/base.log &

nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-ucenter-service/fd-font-ucenter-service.jar >> /data/logs/dubbo/ucenter.log &

nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-misc-service/fd-font-misc-service.jar  >>   /data/logs/dubbo/misc.log &


mongod --dbpath=/data/mongodb/data --logpath=/data/mongodb/log/mongodb.log --logappend --fork  --bind_ip 127.0.0.1,59.108.205.146,10.0.0.0/8


/data/servers/tomcat_sync/webapps/fd-font-syn-web


nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-syn-service/fd-font-syn-service.jar   >> /data/logs/dubbo/sersyn.log &
nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-syn-business/fd-font-syn-business.jar >> /data/logs/dubbo/bussyn.log  &


/data/scripts/pags/fd-font-api-business-bin.zip          tomcat_misc/webapps/fd-font-misc-web       


ps aux | grep fd-font-base-service | grep -v grep | awk '{print $2}' | xargs kill -9 


ps aux | grep fd-font-api-service | grep -v grep | awk '{print $2}' | xargs kill -9



mongod --dbpath=/data/mongodb/data --logpath=/data/mongodb/log/mongodb.log --logappend --fork


ln -s /data/ttt/  /opt/upload/upload_java


ALTER TABLE open_platform.cpt_app MODIFY COLUMN APP_NAME VARCHAR(255) BINARY CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT "应用名称";





if [ $1 == synb ]; then
ps  aux | grep fd-font-syn-business | grep -v grep | awk '{print $2}' | xargs kill -9  && echo "停止服务！"
mv  ${dirwork}/fd-font-syn-business   ${dirback}/fd-font-syn-business-${ddd}        &&  echo "备份完成！"
cp  ${dirpag}/fd-font-syn-business-bin.zip  ${dirwork}/                           &&   echo "文件完成拷贝！"
cd  ${dirwork}
/usr/bin/unzip   fd-font-syn-business-bin.zip  >> /dev/null      2>&1 &
sleep 5

nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-syn-business/fd-font-syn-business.jar  >> /data/logs/dubbo/bussyn.log 2>&1  &

fi



if [ $1 == syns ]; then
ps  aux | grep fd-font-syn-service | grep -v grep | awk '{print $2}' | xargs kill -9  && echo "停止服务！"
mv  ${dirwork}/fd-font-syn-service   ${dirback}/fd-font-syn-service-${ddd}        &&  echo "备份完成！"
cp  ${dirpag}/fd-font-syn-service-bin.zip  ${dirwork}/                           &&   echo "文件完成拷贝！"
cd  ${dirwork}
/usr/bin/unzip   fd-font-syn-service-bin.zip  >> /dev/null      2>&1 &
sleep 5

nohup /usr/local/jdk1.8/bin/java -jar /data/dubbo/fd-font-syn-service/fd-font-syn-service.jar  >> /data/logs/dubbo/sersyn.log 2>&1  &

fi




ALTER TABLE `font_shop`.`fs_user_font_detail`     CHANGE `IS_COLLECT` `IS_COLLECT` VARCHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' NULL  COMMENT '是否收藏该字体',     CHANGE `IS_SCORE` `IS_SCORE` VARCHAR(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '0' NULL  COMMENT '是否对该字体进行评分';


update fs_user_font_detail set IS_SCORE = '0' where IS_SCORE is null;
update fs_user_font_detail set IS_COLLECT = '0' where IS_COLLECT is null;



ddd=`ps aux | grep  tomcat_dubbo |  grep -v grep | awk '{print $2}'`

if [[ ! $ddd ]]; then
	echo  666 |  mail -s 555  li.cq@founder.com
fi




echo  666 |  mail -s 555  li.cq@founder.com


update fs_font_version set version_name = substring('version_name' ,3) where version_name like 'v%';


update fs_font_version set version_name = '1.0' where version_name = 'rsion_name';



         location ~ ^/html/share/.* {

                proxy_set_header Host $http_host;
                proxy_redirect     off;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP  $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_pass   http://10.45.147.69:8300;
                        }

         location ~ ^/misc/web/.* {

                proxy_set_header Host $http_host;
                proxy_redirect     off;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP  $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_pass   http://10.45.147.69:8300;
                        }


/data/servers/tomcat_misc/webapps/fd-font-misc-web


ALTER TABLE `font_shop`.`fs_font_picture` 
ADD INDEX `pic_id_index` USING BTREE (`PIC_ID` ASC);



ALTER TABLE `fs_font_version` 
ADD COLUMN `VISIT_NUM` INT NULL DEFAULT 0 AFTER `WEBFONT_URL`;

ALTER TABLE `font_shop`.`fs_font_version` 
ADD COLUMN `SLOGEN_PIC_URL` VARCHAR(200) NULL COMMENT '口号图片地址' AFTER `VISIT_NUM`;

ALTER TABLE `font_shop`.`fs_font_version` 
ADD COLUMN `TTF_MD5` VARCHAR(100) NULL COMMENT 'ttf文件有效性验证' AFTER `SLOGEN_PIC_URL`;






grep -r '$date' /opt/servers/tomcat_frontweb/webapps/fd-fontopen-front-web/*



synb

syns





server {
listen 443; 
server_name api.xiezixiansheng.com;
ssl on;
root /opt/servers/tomcat_app/webapps/fd-fontshop-app-web;
index index.jsp;
ssl_certificate   /opt/servers/nginx/sslks/213968084840427.pem;
ssl_certificate_key  /opt/servers/nginx/sslks/213968084840427.key;
ssl_session_timeout 5m;
ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_ciphers AESGCM:ALL:!DH:!EXPORT:!RC4:+HIGH:!MEDIUM:!LOW:!aNULL:!eNULL;
ssl_prefer_server_ciphers on;

      location ~ /fontstore/.* {
            proxy_pass http://10.45.147.69:8080;
            proxy_connect_timeout 30s;
            proxy_send_timeout 90;
            proxy_read_timeout 90;
            proxy_buffer_size 32k;
            proxy_buffers 4 32k;
            proxy_busy_buffers_size 64k;
            proxy_redirect off;
            proxy_hide_header Vary;
            proxy_set_header Accept-Encoding '';
            proxy_set_header Host $host;
            proxy_set_header Referer $http_referer;
            proxy_set_header Cookie $http_cookie;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }

      location  / {
            proxy_pass http://tomcativs//;
            proxy_connect_timeout 30s;
            proxy_send_timeout 90;
            proxy_read_timeout 90;
            proxy_buffer_size 32k;
            proxy_buffers 4 32k;
            proxy_busy_buffers_size 64k;
            proxy_redirect off;
            proxy_hide_header Vary;
            proxy_set_header Accept-Encoding '';
            proxy_set_header Host $host;
            proxy_set_header Referer $http_referer;
            proxy_set_header Cookie $http_cookie;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }

}




useradd -G ftp -s /sbin/nologin -d /opt/upload/resources/front/activity  -M fzh5




ftp://101.201.153.0/
用户名：fzh5
密码：zty2016%






#!/bin/bash
while [ true ]; do
/bin/sleep 1
/usr/bin/rsync -avzP  --password-file=/data/scripts/ppp.pwd  rsync@10.45.10.158::ztydata  /data/upload/ &  >> /data/logs/rrr.log    2>&1
done





nohup  sh /data/scripts/rsypersec.sh  >> /data/logs/rrr.log  2>&1  &





CREATE TABLE `fs_font_statistics` (
  `FONT_ID` char(32) NOT NULL DEFAULT '',
  `downloadc` double DEFAULT NULL,
  `sharec` double DEFAULT NULL,
  `collectc` double DEFAULT NULL,
  `visitc` double DEFAULT NULL,
  `updatestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `rc` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;










    location ~* \.(ttf|ttc|otf|eot|woff|font.css)$ {
        add_header Access-Control-Allow-Origin "http://test.ftp.xiezixiansheng.com/";
    }











nohup  sh /data/scripts/rsypersec.sh  >> /data/logs/rrr.log  2>&1  &



show engine innodb status \G;

show processlist;

show OPEN TABLES where In_use > 0;


正在锁的事务
SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCKS; 
 
等待锁的事务
SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCK_WAITS; rtimeout';

161216 20:29:25

161216 20:29:25 mysqld_safe mysqld restarted




select b.FONT_NAME as fontName ,b.FONT_Id as fontId ,p.PIC_URL as showPicUrl, b.SHAR
E_TYPE as shareType, b.TTF_SIZE as TTFSize ,b.INTRODUCTION as introduction, b.create_date as createDate, (select pic_url from fs_picture where id = b.sdk_show_picture_id) as sdkShowPicUrl,b.author as
 author  from (select a.*,f.FONT_NAME,f.SHARE_TYPE,f.OPEN_STATUS,f.INTRODUCTION,f.author from  (SELECT  g.sdk_show_picture_id,g.FONT_ID,g.TTF_SIZE, g.SHOW_PICTURE_ID,g.CREATE_DATE FROM  (SELECT * FRO
M fs_font_version  WHERE type = '0' and status = '2'  and IS_DELETED = '0') g, (SELECT font_id, MAX(version_name) AS version_name FROM fs_font_version  WHERE  type = '0'  and status = '2' and IS_DELE
TED = '0'  GROUP BY FONT_ID) h     WHERE g.FONT_ID = h.font_id AND g.version_name = h.version_name order by g.update_date desc  ) a left join (select * from fs_font where is_deleted = '0') as f on f.
id = a.FONT_ID where f.FONT_NAME is not null and f.OPEN_STATUS='0' and f.channel is null  and f.FORMATER not in ('Y') order by f.update_date desc  ) b left join (select * from fs_picture where is_del
eted = '0') p on b.SHOW_PICTURE_ID = p.ID where b.OPEN_STATUS ='0'  order by b.CREATE_DATE desc;





tapp=`ps aux | grep  tomcat_app |  grep -v grep | awk '{print $2}'`
if [[ ! $tapp ]]; then
	echo  "tomcat_app进程不存在" |  mail -s  prosswarn  li.cq@founder.com
	echo  "tomcat_app进程不存在" |  mail -s  prosswarn  18310232122@139.com
fi


tback=`ps aux | grep  tomcat_back |  grep -v grep | awk '{print $2}'`
if [[ ! $tback ]]; then
	echo  "tomcat_back进程不存在" |  mail -s  prosswarn  li.cq@founder.com
	echo  "tomcat_back进程不存在" |  mail -s  prosswarn  18310232122@139.com
fi







tfront=`ps aux | grep  tomcat_frontweb |  grep -v grep | awk '{print $2}'`
if [[ ! $tfront ]]; then
	echo  "tomcat_frontweb进程不存在" |  mail -s  prosswarn  li.cq@founder.com
	echo  "tomcat_frontweb进程不存在" |  mail -s  prosswarn  18310232122@139.com
fi




10.45.10.158 redis.xiezixiansheng.com
101.201.222.249 ftp.xiezixiansheng.com

10.45.10.158 api.xiezixiansheng.com

10.45.10.158 console.xiezixiansheng.com

10.45.10.158 open.xiezixiansheng.com

* * * * *    /bin/sh   /data/scripts/mon.sh    >> /dev/null      2>&1

useradd -G ftp -s /sbin/nologin -d /opt/upload/h5upload  -M  h5upload

h52016%


http://open.xiezixiansheng.com/fof/a/checkHost.json






ALTER TABLE fs_font_statistics
ADD downloadcWeb double DEFAULT NULL;

ALTER TABLE fs_font_statistics
ADD visitcWeb double DEFAULT NULL;

ALTER TABLE fs_font_statistics
ADD Webrc double DEFAULT NULL;

ALTER TABLE `open_platform`.`cpt_app`     ADD `WHITE_LIST` VARCHAR(2000) NULL  COMMENT '白名单';















