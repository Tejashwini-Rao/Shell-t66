 set -e

COMPONENT= cart
 source common.sh


NodeJS

DOWNLOAD

 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
 systemctl daemon-reload
 systemctl start cart
 systemctl enable cart