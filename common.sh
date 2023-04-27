
statuscheck() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 1
  fi
}

NodeJS() {

echo Downloading nodejs dependencies
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash &>>/tmp/${COMPONENT}.log
statuscheck

echo installing Nodejs
 yum install nodejs -y &>>/tmp/${COMPONENT}.log
 statuscheck
}

Appuser(){
id roboshop &>>/tmp/${COMPONENT}.log
if [$? -ne 0];
then
 echo adding roboshop user
 useradd roboshop
 statuscheck
 fi
 }

Download (){
echo Downloading ${COMPONENT} content
 curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip"&>>/tmp/${COMPONENT}.log
  statuscheck
  }

Appclean(){
  echo Cleaning old app content ${COMPONENT} content
     cd /home/roboshop&>>/tmp/${COMPONENT}.log && rm -rf ${COMPONENT}&>>/tmp/${COMPONENT}.log
     statuscheck
  echo extract application archive
    unzip -o /tmp/${COMPONENT}.zip&>>/tmp/${COMPONENT}.log && mv ${COMPONENT}-main ${COMPONENT}&>>/tmp/${COMPONENT}.log && cd ${COMPONENT}&>>/tmp/${COMPONENT}.log
     statuscheck
     }


Npm()
{
     npm install&>>/tmp/${COMPONENT}.log
     statuscheck

    }




Service(){

  echo Update SystemD Config

  sed -i -e 's/MONGO_DNSNAME/mongodb-dev.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb-dev.roboshop.internal/' -e 's/REDIS_ENDPOINT/redis-dev.roboshop.internal/'
  -e 's/CATALOGUE_ENDPOINT/catalogue-dev.roboshop.internal/' -e 's/AMQPHOST/rabbitmq-dev.roboshop.internal/' -e 's/CARTHOST/cart-dev.roboshop.internal/'
  -e 's/USERHOST/user-dev.roboshop.internal/' -e 's/CARTENDPOINT/cart-dev.roboshop.internal/' -e 's/DBHOST/mysql-dev.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service &>>/tmp/${COMPONENT}.log
  StatusCheck
  echo moving  app content
     mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>/tmp/${COMPONENT}.log
     statuscheck

  echo restarting the service
    systemctl daemon-reload&>>/tmp/${COMPONENT}.log && systemctl start ${COMPONENT}&>>/tmp/${COMPONENT}.log && systemctl enable ${COMPONENT}&>>/tmp/${COMPONENT}.log
    statuscheck

  }


