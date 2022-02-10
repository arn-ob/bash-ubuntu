#!/bin/bash

# Issue: Getting Error while executing a .sh file: /bin/bash^M: bad interpreter
# sed -i -e 's/\r$//' ./ubuntu-20-04.sh

echo 'Domain manage for ubuntu 20.04';

while :
do
    echo $'\n';
    echo '0: Exit';
    echo '1: Install domain';
    
    echo $'\n';
    read -p 'Select your choice: ' selector;
    echo $'\n';

    case $selector in
        0)
            echo "Exit"
            break;
        ;;
        1)
            echo "sudo apt-get update";
            sudo apt-get update

            echo "Enter Domain Name"
            read -p 'Domain (Ex: xx.xx): ' domain

            echo "
                server {
                        listen 80;
                        listen [::]:80;
                        root /var/www/html;;
                        index index.nginx-debian.html;
                        
                        server_name $domain;
                        
                        location / {
                            try_files $uri $uri/ =404;
                        }
                }
            " >> /etc/nginx/sites-available/$domain
            
            echo "Map With Site Enable";
            sudo ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/
            
            systemctl reload nginx
            
            echo "letsencrypt install"
            certbot --nginx -d $domain
            
            echo "Domain Create Done";
            echo $'\n';
            continue;
        ;;
        *)
            echo "Sorry, Try Again"
            continue;
        ;;
    esac
done
