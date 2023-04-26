
StatusCheck() {
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
