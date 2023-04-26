
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
 yum install nodejs -y &>>/tmp/${COMPONENT}.log
 statuscheck
}

Roboshop(){
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

Unzip(){
  echo Unziping ${COMPONENT} content
     cd /home/roboshop&>>/tmp/${COMPONENT}.log
     rm -rf ${COMPONENT}&>>/tmp/${COMPONENT}.log
     unzip -o /tmp/${COMPONENT}.zip&>>/tmp/${COMPONENT}.log
     mv -main ${COMPONENT}&>>/tmp/${COMPONENT}.log
     cd ${COMPONENT}&>>/tmp/${COMPONENT}.log
     npm install&>>/tmp/${COMPONENT}.log
     statuscheck

    }
Move() {
echo moving  ${COMPONENT} content
   mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service&>>/tmp/${COMPONENT}.log
    systemctl daemon-reload&>>/tmp/${COMPONENT}.log
    systemctl start ${COMPONENT}&>>/tmp/${COMPONENT}.log
    systemctl enable ${COMPONENT}&>>/tmp/${COMPONENT}.log
    statuscheck

  }


