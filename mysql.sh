COMPONENT=mysql
source common.sh
 set -e

 if [ -z "$MYSQL_PASSWORD" ]; then
   echo -e "\e[33m env variable MYSQL_PASSWORD is missing \e[0m"
   exit 1
 fi
 echo downloading repo
 curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>/tmp/${COMPONENT}.log
 statuscheck

echo install mysql
 yum install mysql-community-server -y &>>/tmp/${COMPONENT}.log
 statuscheck

echo start services
 systemctl enable mysqld &>>/tmp/${COMPONENT}.log && systemctl restart mysqld &>>/tmp/${COMPONENT}.log
 statuscheck

#echo "show databases;" | mysql -uroot -p$MYSQL_PASSWORD &>>/tmp/${COMPONENT}.log
#if [ $? -ne 0 ]; then
 # echo Changing Default Password
  #DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
  #echo "alter user 'root'@'localhost' identified with mysql_native_password by '$MYSQL_PASSWORD';" | mysql --connect-expired-password -uroot -p${DEFAULT_PASSWORD} &>>/tmp/${COMPONENT}.log
  #statuscheck
#fi


#echo "show plugins;" | mysql -uroot -p$MYSQL_PASSWORD 2>&1 | grep validate_password &>>/tmp/${COMPONENT}.log
#if [ $? -eq 0 ]; then
 # echo Remove Password Validate Plugin
  #echo "uninstall plugin validate_password;" | mysql -uroot -p$MYSQL_PASSWORD &>>/tmp/${COMPONENT}.log
  #statuscheck
#fi


echo Extract & Load Schema
 cd /tmp &>>/tmp/${COMPONENT}.log && unzip -o mysql.zip &>>/tmp/${COMPONENT}.log &&  cd mysql-main &>>/tmp/${COMPONENT}.log && mysql -u root -p$MYSQL_PASSWORD <shipping.sql &>>/tmp/${COMPONENT}.log
 statuscheck




