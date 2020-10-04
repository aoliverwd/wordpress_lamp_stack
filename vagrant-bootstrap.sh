# Common
sudo apt update
sudo apt install -y curl
sudo apt install -y git

# Enable Ubuntu Firewall and allow SSH & MySQL Ports
ufw enable
ufw allow 22
ufw allow 3306

# Apache
sudo apt install -y apache2
sudo a2enmod expires
sudo a2enmod headers
sudo a2enmod include
sudo a2enmod rewrite

# PHP
sudo apt install -y php
sudo apt install -y libapache2-mod-php
sudo apt install -y php-all-dev
sudo apt install -y php-sqlite3
sudo apt install -y php-common
sudo apt install -y php-mcrypt
sudo apt install -y php-mysql
sudo apt install -y php-curl
sudo apt install -y php-yaml
sudo apt install -y sendmail
sudo apt install -y php-zip

# Enable rewrites via .htaccess
sudo tee -a /etc/apache2/sites-available/000-default.conf > /dev/null <<EOT
<Directory /var/www/html>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
</Directory>
EOT

# Restart apache
sudo service apache2 restart

# MySQL
sudo apt install -y mysql-server

sudo mysqld --initialize-insecure --user=root
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ''; FLUSH PRIVILEGES;"

# Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

# WP CLI
php -r "copy('https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar', 'wp-cli.phar');"
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Crate WordPress Database
sudo mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE wordpress /*\!40100 DEFAULT CHARACTER SET utf8 */;
CREATE USER wordpress@localhost IDENTIFIED BY 'wordpress';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# cd into html root
cd /var/www/html

# Download later WordPress Version
wp core download

# Crate WordPress config
wp config create --dbname=wordpress --dbuser=wordpress --dbpass=wordpress --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
PHP

# Install WordPress
wp core install --url=http://wp.local --title=WordPress-Website --admin_user=wpuser --admin_password=wordpress --admin_email=alexoliverwd@gmail.com

# remove index.html
rm index.html

# WordPress .htaccess bootstrap
git clone https://gist.github.com/06da453792a4283e0857e7b4d04726b5.git
mv ./06da453792a4283e0857e7b4d04726b5/.htaccess .
rm -r 06da453792a4283e0857e7b4d04726b5