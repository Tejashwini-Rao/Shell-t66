 set -e

 source common.sh
 COMPONENT= cart

NodeJS

DOWNLOAD

 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
 systemctl daemon-reload
 systemctl start cart
 systemctl enable cart