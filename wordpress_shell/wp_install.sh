#!/bin/bash -v

sudo apt-get -y install apache2
sudo apt-get -y install php5

sudo apt-get -y install unzip
sudo apt-get -y install php5-mysql
sudo apt-get -y install mysql-client

# Install Wordpress
wget http://wordpress.org/latest.zip
sudo unzip -q latest.zip -d /var/www/html/
sudo chown -R www-data.www-data /var/www/html/wordpress
sudo chmod -R 755 /var/www/html/wordpress
sudo mkdir -p /var/www/html/wordpress/wp-content/uploads
sudo chown -R :www-data /var/www/html/wordpress/wp-content/uploads
cd /var/www/html/wordpress/
sudo cp wp-config-sample.php wp-config.php

sudo sed -i s/database_name_here/$db_name/ /var/www/html/wordpress/wp-config.php
sudo sed -i s/username_here/$db_user/      /var/www/html/wordpress/wp-config.php
sudo sed -i s/password_here/$db_password/  /var/www/html/wordpress/wp-config.php
sudo sed -i s/localhost/$db_ipaddr/        /var/www/html/wordpress/wp-config.php

#sed -i "/Deny from All/d" /etc/httpd/conf.d/wordpress.conf
#sed -i "s/Require local/Require all granted/" /etc/httpd/conf.d/wordpress.conf
#sed -i s/database_name_here/$db_name/ /etc/wordpress/wp-config.php
#sed -i s/username_here/$db_user/      /etc/wordpress/wp-config.php
#sed -i s/password_here/$db_password/  /etc/wordpress/wp-config.php
#sed -i s/localhost/$db_ipaddr/        /etc/wordpress/wp-config.php

