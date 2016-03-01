#!/usr/bin/env bash

block="server {
    listen 80;
    listen [::]:80;

    root /var/www/site/www;
    index index.html index.htm index.php;

    server_name localhost;

    location / {
        try_files \$uri \$uri/ =404;
    }

    error_page 404 /404.html;
    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
        root /var/www/site/www;
    }

    location ~ \.php$ {
        try_files \$uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)\$;
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
}
"

sudo bash -c "echo '$block' > /etc/nginx/sites-available/devserver"
sudo ln -fs "/etc/nginx/sites-available/devserver" "/etc/nginx/sites-enabled/devserver"
sudo service nginx restart
sudo service php5-fpm restart
