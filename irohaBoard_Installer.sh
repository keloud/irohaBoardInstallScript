#!/bin/bash
##Package
#Package Update
apt update
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
sed -e '/<Directory /var/www/>/,/</Directory> s/AllowOverride None/AllowOverride All/g /etc/apache2/apache2.conf'
systemctl restart apache2

##MySQL
#MySQL System Setting
systemctl enable mysql
systemctl start mysql
#MySQL Setting
mysql --defaults-extra-file=./irohaBoard_Installer_MySQL.cnf -N < irohaBoard_Installer_MySQL.sql]
sed -e '/[mysqld]/i sql_mode=ALLOW_INVALID_DATES/' /etc/mysql/mysql.conf.d/mysqld.cnf

##CakePHP
wget https://github.com/cakephp/cakephp/archive/2.10.3.tar.gz
tar xvf 2.10.3.tar.gz
mv cakephp-2.10.3/  /var/www/cake/

#irohaBoard
wget https://github.com/irohasoft/irohaboard/archive/v0.9.8.1.tar.gz
tar xvf v0.9.8.1.tar.gz
rm -d -r -f  /var/www/html/
mv irohaboard-0.9.8.1/ /var/www/html/
sed -e "s/'login' => 'root',/'login' => 'ib_user',/g" /var/www/html/Config/database.php
sed -e "s/'password' => '',/'password' => 'f1b3f805a8b4ea6d35f2de4c4fbaf3df1caaaf94',/g" /var/www/html/Config/database.php
sed -e "s/'database' => 'hiiragi2',/'database' => 'ib',/g" /var/www/html/Config/database.php
sudo chown -R www-data:www-data /var/www/

##After
reboot