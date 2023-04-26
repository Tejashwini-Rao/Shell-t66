 set -e
 source common
 COMPONENT= cart

NodeJS

 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
 systemctl daemon-reload
 systemctl start cart
 systemctl enable cart