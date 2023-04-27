set -e
COMPONENT=payment
source=common.sh
yum install python36 gcc python3-devel -y


Appuser

Appclean

pip3 install -r requirements.txt

Service()