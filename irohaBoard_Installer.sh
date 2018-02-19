#!/bin/bash
while :
do
    echo "Set Mysql root Password"
    read -srp "Password: " sqlPass
    echo
    echo "Retype Mysql root Password"
    read -srp "Password: " RsqlPass
    echo
    if [ $sqlPass = $RsqlPass ]; then
        break
    else
        echo "\e[41m Password is incorrect.\e[m"
    fi
done
echo
sed -ie "s/mysqlPass/$sqlPass/" ./irohaBoard_Installer_MySQL.cnf

while :
do
    echo "Set Mysql User irohaBoard root Password"
    read -srp "Password: " irohaPass
    echo
    echo "Retype Mysql User irohaBoard root Password"
    read -srp "Password: " RirohaPass
    echo
    if [ $irohaPass = $RirohaPass ]; then
        break
    else
        echo "\e[41m Password is incorrect.\e[m"
    fi
done
echo
sed -ie "s/irohaPass/$irohaPass/" ./irohaBoard_Installer_MySQL.sql

while :
do
    echo "Set Mysql User irohaBoard remote Password"
    read -srp "Password: " irohaRemotePass
    echo
    echo "Retype Mysql User irohaBoard remote Password"
    read -srp "Password: " RirohaRemotePass
    echo
    if [ $irohaRemotePass = $RirohaRemotePass ]; then
        break
    else
        echo "\e[41m Password is incorrect.\e[m"
    fi
done
echo
sed -ie "s/irohaRemotePass/$irohaRemotePass/" ./irohaBoard_Installer_MySQL.sql

echo -e "\e[33m Package\e[m"
echo -e "\e[34m Package Update\e[m"
apt update
echo -e "\e[34m Package Install\e[m"
apt install -y php php-common php-mysql php-intl php-mbstring composer apache2 libapache2-mod-php mysql-server

echo -e "\e[33m PHP\e[m"
echo -e "\e[34m PHP Setting\e[m"
phpenmod pdo pdo_mysql mysqli mysqlnd

echo -e "\e[33m Apache\e[m"
echo -e "\e[34m Apache System Setting\e[m"
systemctl enable apache2
systemctl start apache2
echo -e "\e[34m Apache Setting\e[m"
a2enmod rewrite
sed -ie '/Directory \/var\/www/,/Directory/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
systemctl restart apache2

echo -e "\e[33m MySQL\e[m"
echo -e "\e[34m MySQL System Setting\e[m"
systemctl enable mysql
systemctl start mysql
echo -e "\e[34m MySQL Setting\e[m"
mysql --defaults-extra-file=irohaBoard_Installer_MySQL.cnf < irohaBoard_Installer_MySQL.sql
sed -ie '/\[mysqld\]/a sql_mode=ALLOW_INVALID_DATES' /etc/mysql/mysql.conf.d/mysqld.cnf
sed -e 's/bind-address/#bind-address/' /etc/mysql/mysql.conf.d/mysqld.cnf

echo -e "\e[33m CakePHP\e[m"
wget https://github.com/cakephp/cakephp/archive/2.10.7.tar.gz
tar xvf ./2.10.3.tar.gz
mv cakephp-2.10.3/  /var/www/cake/

echo -e "\e[33m irohaBoard\e[m"
wget https://github.com/irohasoft/irohaboard/archive/v0.9.13.tar.gz
tar xvf ./v0.9.8.1.tar.gz
rm -d -r -f  /var/www/html/
mv irohaboard-0.9.8.1/ /var/www/html/
sed -ie "s/'login' => 'root',/'login' => 'ib_user',/g" /var/www/html/Config/database.php
sed -ie "s/'password' => '',/'password' => '$irohaPass',/g" /var/www/html/Config/database.php
sed -ie "s/'database' => 'hiiragi2',/'database' => 'ib',/g" /var/www/html/Config/database.php
sudo chown -R www-data:www-data /var/www/

echo
echo "Login ID: root"
echo "Password: irohaboard"
echo "Please change your password immediately after login"
echo -e "\e[33m Restart by pressing Enter key\e[m"
read
reboot

exit 0
