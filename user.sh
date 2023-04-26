 set -e

 source common
 COMPONENT= user

 NodeJS





 mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
 systemctl daemon-reload
 systemctl start user
 systemctl enable user