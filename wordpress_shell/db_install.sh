#!/bin/bash -v

sudo apt-get update

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${db_rootpassword}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${db_rootpassword}"

sudo apt-get -y -q install mysql-server
sed -e "s/^bind-address*/#bind-address/" -i /etc/mysql/my.cnf
service mysql restart

# Setup MySQL root password and create a user
mysqladmin -u root password $db_rootpassword
cat << EOF | mysql -u root --password=$db_rootpassword
CREATE DATABASE $db_name;
GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%'
IDENTIFIED BY '$db_password';
FLUSH PRIVILEGES;
EXIT
EOF
