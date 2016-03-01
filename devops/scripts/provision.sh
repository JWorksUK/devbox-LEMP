#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

# Update Package List
sudo apt-get update

# Update System Packages
sudo apt-get -y upgrade

# Force Locale
sudo locale-gen en_GB.UTF-8

# Random Shit
sudo apt-get install -y zsh git expect

# Oh My Zsh
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
sudo chsh -s $(which zsh) vagrant

# Install Nginx & PHP-FPM
sudo apt-get install -y --force-yes nginx php5-fpm php5-mysql

# Remove default sites
sudo rm /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-available/default
sudo rm -rf /usr/share/nginx/html
sudo service nginx restart

# Setup Some PHP-FPM Options
# DEV
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/fpm/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/fpm/php.ini
sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php5/fpm/php.ini
sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php5/fpm/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php5/fpm/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php5/fpm/php.ini
sudo sed -i "s/expose_php = On/expose_php = Off/" /etc/php5/fpm/php.ini

# Set The Nginx & PHP-FPM User
# DEV
sudo sed -i "s/user www-data;/user vagrant;/" /etc/nginx/nginx.conf
sudo sed -i "s/# server_names_hash_bucket_size.*/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf

sudo sed -i "s/user = www-data/user = vagrant/" /etc/php5/fpm/pool.d/www.conf
sudo sed -i "s/group = www-data/group = vagrant/" /etc/php5/fpm/pool.d/www.conf

sudo sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php5/fpm/pool.d/www.conf
sudo sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php5/fpm/pool.d/www.conf
sudo sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php5/fpm/pool.d/www.conf

sudo service nginx restart
sudo service php5-fpm restart

# Add Vagrant User To WWW-Data
sudo usermod -a -G www-data vagrant
id vagrant
groups vagrant

# Turn off server tokens
sudo sed -i "s/# server_tokens off;/server_tokens off;/" /etc/nginx/nginx.conf

# Install MySql
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password secret"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password secret"
sudo apt-get install -y mysql-server
# sudo mysql_secure_installation
