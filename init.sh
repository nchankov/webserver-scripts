sudo apt update
sudo apt upgrade
sudo apt install apache2
sudo apt install mysql-server
sudo apt install php libapache2-mod-php php-mysql
#install certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

#install software repo for different versions of php
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update -y

#install php7.4
sudo apt-get install php7.4 php7.4-fpm php7.4-mysql libapache2-mod-php7.4 -y

#add this into crontab:
#sudo certbot renew --dry-run