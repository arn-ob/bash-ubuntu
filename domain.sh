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

            sudo mkdir -p /var/www/$domain/html
            
            sudo chown -R $USER:$USER /var/www/$domain/html
            
            sudo chmod -R 755 /var/www/$domain/html
            
            echo "Create index.nginx-debian.html";
            
            echo "
                <!DOCTYPE html>
                <html>
                    <head>
                        <title>Welcome to nginx!</title>
                        <style>
                            body {
                                width: 35em;
                                margin: 0 auto;
                                font-family: Tahoma, Verdana, Arial, sans-serif;
                            }
                        </style>
                    </head>
                    <body>
                        <h1>Welcome to nginx!</h1>
                        <p>If you see this page, the nginx web server is successfully installed and
                        working. Further configuration is required.</p>
                        <p>For online documentation and support please refer to
                        <a href="http://nginx.org/">nginx.org</a>.<br/>
                        Commercial support is available at
                        <a href="http://nginx.com/">nginx.com</a>.</p>
                        <p><em>Thank you for using nginx.</em></p>
                    </body>
                </html>
            " >> /var/www/$domain/html/index.nginx-debian.html;
            
            echo "
                server {
                        listen 80;
                        listen [::]:80;
                        root /var/www/$domain/html;
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