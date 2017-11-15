#!/usr/bin/env bash
##Package
#Package Update
apt update
apt upgrade
#Package Install
apt install -y php php-common php-mysql php-intl php-mbstring composer apache2 libapache2-mod-php mysql-server

##PHP
#PHP Setting
phpenmod pdo pdo_mysql mysqli mysqlnd

##Apache
#Apache System Setting
systemctl enable apache2
systemctl start apache2
#Apache Setting
a2enmod rewrite
# <- vimの部分
systemctl restart apache2

##MySQL
#MySQL System Setting
systemctl enable mysql
systemctl start mysql
#MySQL Setting
mysql --defaults-extra-file=./irohaBoard_Installer_MySQL.cnf -N < irohaBoard_Installer_MySQL.sql
# <- vimの部分

##CakePHP
wget https://github.com/cakephp/cakephp/archive/2.10.3.tar.gz
tar xvf 2.10.3.tar.gz
mv cakephp-2.10.3/  /var/www/cake/

#irohaBoard
wget https://github.com/irohasoft/irohaboard/archive/v0.9.8.1.tar.gz
tar xvf v0.9.8.1.tar.gz
rm -d -r -f  /var/www/html/
mv irohaboard-0.9.8.1/ /var/www/html/
# <- vimの部分

sudo chown -R www-data:www-data /var/www/