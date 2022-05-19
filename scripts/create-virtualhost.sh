#!/bin/bash
domain=$1
dir=$2
nginxConf=./config/nginx/conf.d/$domain.conf
if [ "$(whoami)" != 'root' ]; then
	echo $"You have no permission to run $0 as non-root user. Use sudo"
	exit;
fi

if [ "$domain" == "" ]; then
		echo -e $"Please provide domain.\nEx: ./scripts/create-virtualhost.sh {your_domain} {your_project_in_www}"
		exit;
fi

if [ "$dir" == "" ]; then
	echo -e $"Please provide directory.\nEx: ./scripts/create-virtualhost.sh {your_domain} {your_project_in_www}"
	exit;
fi

if ! [ -e www/$dir ]; then
	echo "$dir doesn't exist."
	exit;
fi

### check if domain already exists
if [ -e $nginxConf ];
	then
    # Delete nginx configuration
		rm $nginxConf;
fi   
    # create new nginx conf
echo "
	server {
    listen 80;
    listen [::]:80;
    server_name  $domain;

    index index.php index.html;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /var/www/html/$dir/public;
    client_max_body_size 21M;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        include /etc/nginx/fastcgi_params;
        fastcgi_pass app:9000;
        fastcgi_index index.php;
        fastcgi_connect_timeout 250;
        fastcgi_send_timeout 250;
        fastcgi_read_timeout 250;
        fastcgi_intercept_errors on;
        fastcgi_param SCRIPT_FILENAME /var/www/html/$dir/public\$fastcgi_script_name;
        fastcgi_temp_file_write_size 10m;
        fastcgi_busy_buffers_size 512k;
        fastcgi_buffer_size 512k;
        fastcgi_buffers 16 512k;

    }
    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }
}" > ./config/nginx/conf.d/$domain.conf

# Add domain for linux
if ! echo "127.0.0.1	$domain" >> /etc/hosts
then
	echo $"ERROR: Not able to write in /etc/hosts"
	exit;
else
	echo -e $"Host added to /etc/hosts file \n"
fi

### Add domain in c:\WINDOWS\system32\drivers\etc\hosts
if [ -e c:\WINDOWS\system32\drivers\etc\hosts ]
then
    if ! echo -e "\r127.0.0.1       $domain" >> c:\WINDOWS\system32\drivers\etc\hosts
    then
        echo $"ERROR: Not able to write in c:\WINDOWS\system32\drivers\etc\hosts (Hint: Try running Bash as administrator)"
    else
        echo -e $"Host added to c:\WINDOWS\system32\drivers\etc\hosts file \n"
    fi
fi

# Restart nginx.
docker restart webserver

### show the finished message
echo -e $"Complete!\nYou just removed Virtual Host http://$domain"
